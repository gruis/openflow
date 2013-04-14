class OpenFlow
  module Proto
    module V0x01
      class Message
        class Header < BinData::Record

          class HeaderType < BinData::BasePrimitive
            TYPES = [
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

            def sensible_default
              nil
            end

            def read_and_return_value(io)
              type = io.readbytes(1).unpack("C")[0]
              TYPES[type]
            end

            def value_to_binary_string(value)
              [TYPES.index(value)].pack("C")
            end
          end # class::Type < BinData::BasePrimitive

        end # class::Header
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
