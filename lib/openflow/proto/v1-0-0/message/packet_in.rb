class OpenFlow
  module Proto
    module V0x01
      class Message
        class PacketIn < BinData::Record

          class PacketInReason < BinData::BasePrimitive
            REASONS = [
              :no_match,
              :action
            ]

            def sensible_default
              nil
            end

            def read_and_return_value(io)
              type = io.readbytes(1).unpack("C")[0]
              REASONS[type]
            end

            def value_to_binary_string(value)
              [REASONS.index(value)].pack("C")
            end
          end # class::PacketInReason < BinData::BasePrimitive

          include Base

          endian :big
          uint32 :buffer_id
          uint16 :total_len
          uint16 :in_port
          packet_in_reason :reason
          uint8 :pad
          string :data, :read_length => :total_len

        end # class::PacketIn
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
