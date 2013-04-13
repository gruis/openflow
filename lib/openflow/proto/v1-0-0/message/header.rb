class OpenFlow
  module Proto
    module V0x01
      class Message
        class Header

          class Record < BinData::Record
            endian :big
            uint8 :version
            uint8 :type
            uint16 :len
            uint32 :xid
          end # class::Record < BinData::Record

          TYPE = [
            # Immutable messages.
            :hello,
            :error,
            :echo_request,
            :echo_reply,
            :vendor,

            # Switch configuration messages.
            :features_request,
            :features_reply,
            :get_config_request,
            :get_config_reply,
            :set_config,

            # Asynchronous messages.
            :packet_in,
            :flow_removed,
            :port_status,

            # Controller command messages.
            :packet_out,
            :flow_mod,
            :port_mod,

            # Statistics messages.
            :stats_request,
            :stats_reply,

            # Barrier messages.
            :barrier_request,
            :barrier_reply,

            # Queue Configuration messages.
            :queue_get_config_request,
            :queue_get_config_reply
          ]

          class << self
            def read(d)
              record = Record.read(d)
              o      = allocate
              o.from_record(record)
              o
            end
          end # class << self

          attr_reader :type, :version, :length, :xid

          def initialize(type, version, length, xid)
            @type    = type
            @version = version
            @length  = length
            @xid     = xid
          end

          def to_binary
            to_record.to_binary_s
          end

          def to_record
            r         = Record.new
            r.type    = TYPE.index(@type)
            r.version = @version
            r.len     = @length
            r.xid     = @xid
            r
          end

          def from_record(record)
            @type    = TYPE[record.type]
            @version = record.version
            @length  = record.len
            @xid     = record.xid
          end


        end # class::Header
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
