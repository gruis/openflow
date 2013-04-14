class OpenFlow
  module Proto
    module V0x01
      class Message
        class Error < BinData::Record
          class ErrorType < BinData::BasePrimitive

            TYPES = [
              # Hello protocol failed.
              :hello_failed,
              # Request was not understood.
              :bad_request,
              # Error in action description.
              :bad_action,
              # Problem modifying flow entry.
              :flow_mod_failed,
              # Port mod request failed.
              :port_mod_failed,
              # Queue operation failed.
              :queue_op_failed
            ]

            def sensible_default
              nil
            end

            def read_and_return_value(io)
              type = io.readbytes(2).unpack("n")[0]
              TYPES[type]
            end

            def value_to_binary_string(value)
              [TYPES.index(value)].pack("n")
            end

          end # class::Type < BinData::Primitive
        end # class::Error
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
