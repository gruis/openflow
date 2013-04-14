require 'openflow/proto'

class OpenFlow
  class Connection < EM::Connection
    include EM::Deferrable

    SUPPORT_MSG = "We support version 0x%02X to 0x%02X inclusive" % [Proto.min_version, Proto.max_version]

    attr_reader :version

    def initialize
      @version   = Proto.max_version
      # Before the protocol negotiation has completed use the methods from the
      # highest locally supported protocol.
      extend(Proto.module_for_version(@version))
      @buffer    = ""
      @xid       = Counter.new
      @callbacks = []
    end

    def post_init
      port, ip = Socket.unpack_sockaddr_in(get_peername)
      $stderr.puts "OpenFlow connection from #{ip}:#{port}"
      send_hello
    end

    def receive_data(d)
      $stderr.puts "recv: #{d.inspect}"
      @buffer << d
      true while proc_msg
    end

    def send_data(type, xid, body = nil)
      len = 8
      if body
        body = body.to_binary_s unless body.is_a?(String)
        len += body.length
      end
      header = build_header(type, version, len, xid)
      msg = "#{header.to_binary_s}#{body}"
      $stderr.puts "send: #{msg.inspect}"
      $stderr.puts "  send header: #{header.inspect}"
      $stderr.puts "  send body: #{body.inspect}"
      super(msg)
      xid
    end


    private

    def send_hello
      send_data(:hello, @xid.next)
    end


    def recv_hello(header, body)
      if (mixin = Proto.module_for_version(header.version)).nil?
        $stderr.puts "Unsupported OpenFlow version #{header.version}"
        data = "#{SUPPORT_MSG} but you support no later than version 0x%02X" % header.version
        send_error(:hello_failed, :incompatible, header.xid, data)
        close_connection(true)
        fail "hello failed: switch max version (0x%02X) is less than local min version (0x%02X)" % [header.version, Proto.min_version]
      else
        # FIXME succeed is called if local version is less than remote max version AND remove min version
        extend mixin unless mixin.version == version
        $stderr.puts "Using protocol version #{self.version}"
        send_features_request
        @heartbeat = EM::PeriodicTimer.new(5) { send_echo_request }
        succeed
      end
    end

    def recv_error(header, body)
      $stderr.puts "ERROR: #{body.inspect}"
      if body.type == :hello_failed
        $stderr.puts "Protocol negotiation failed: #{body.data}"
        @heartbeat && @heartbeat.cancel
        close_connection(true)
        # FIXME succeed is called in recv_hello if local version is less than remote max version in which case this call to fail
        #       will not have an effect
        fail "hello failed: switch min version is greater than local max version (0x%02X)" % [Proto.max_version.to_s(16)]
      end
    end

    def send_error(type, code, xid, data)
      send_data(:error, xid, build_error(type, code, data))
    end

    def proc_msg
      return false if @buffer.length < 8
      header = read_header
      #$stderr.puts "  header: #{header.inspect}"
      body   = read_body(header)
      #$stderr.puts "  body: #{body.inspect}"
      handler = "recv_#{header.type}".intern
      if respond_to?(handler, true)
        send(handler, header, body)
      else
        $stderr.puts "  no #{handler} defined"
      end
      true
    end

    def read_bytes(num)
      _,@buffer = @buffer[0...num],@buffer[num..-1]
      _
    end

    class Counter
      def initialize
        @c = 0
      end

      def next
        @c += 1
      end

      def to_i
        self.next
      end

      def to_s
        self.next
      end

      def val
        c = @c
      end
    end # class::Counter

  end # class::Connection < EM::Connection
end # class::OpenFlow
