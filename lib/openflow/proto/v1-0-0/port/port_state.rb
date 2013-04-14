class OpenFlow
  module Proto
    module V0x01
      class Port < BinData::Record

        class PortState < BinData::BasePrimitive
          def value_to_binary_string(value)
            raise NotImplementedError
          end

          def read_and_return_value(io)
            config = io.readbytes(4).unpack("N")[0]
            {
              :raw        => config,
              :bin        => config.to_s(2),
              :link_down   => config & (1 << 0) != 0,
              :stp_listen  => config & (0 << 8) != 0,
              :stp_learn   => config & (1 << 8) != 0,
              :stp_forward => config & (2 << 8) != 0,
              :stp_block   => config & (3 << 8) != 0,
              :stp_mask    => config & 3 << 8
            }
          end

          def sensible_default
            {
              :link_down   => false,
              :stp_listen  => false,
              :stp_learn   => false,
              :stp_forward => false,
              :stp_block   => false,
              :stp_mask    => false
            }
          end
        end # class::PortFeatures < BinData::BasePrimitive

      end # class::Port
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

