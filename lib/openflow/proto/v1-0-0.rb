require "openflow/proto/v1-0-0/message"
require "openflow/proto/v1-0-0/port"

class OpenFlow
  module Proto
    module V0x01
      include Proto

      def build_error(type, code, data)
         V0x01::Message::Error.new(:type => type, :code => code, :data => data)
      end

      def read_header
        V0x01::Message::Header.read(read_bytes(8))
      end

      def build_header(type, version, len, xid)
        V0x01::Message::Header.new(:type => type, :version => version, :len => len, :xid => xid)
      end

      def read_body(header)
        header.len > 8 ? V0x01::Message.parse(header.type, read_bytes(header.len - 8)) : nil
      end


      def recv_echo_request(header, body)
        send_data(:echo_reply, header.xid, body)
      end

      def send_echo_request
        id = @xid.next
        # TODO track latency
        send_data(:echo_request, id)
        id
      end

      def recv_echo_reply(header, body)
        #$stderr.puts "ECHO REP xid: #{header.xid}"
        # TODO MARK the echo request as being reponded to
        # TODO mark the connection as being healthy
      end

      def recv_packet_in(header, body)
        #$stderr.puts "PACKET_IN: #{body.inspect}"
      end

      def send_features_request
        send_data(:features_request, @xid.next)
      end

      def recv_features_reply(header, body)
        #$stderr.puts "FEATURES: #{body.inspect}"
      end

      def send_get_config_request
        send_data(:get_config_request, @xid.next)
      end

      def recv_get_config_reply(header, body)
        $stderr.puts "GET_CONFIG_REPLY: #{body.inspect}"
      end

      def send_set_config(flags, miss_send_len)
        send_data(
          :set_config,
          @xid.next,
          V0x01::SwitchConfig.new(:miss_send_len => miss_send_len, :flags => flags)
        )
      end

    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
