class OpenFlow
  module Proto
    module V0x01
      class Port < BinData::Record

        class PortFeatures < BinData::BasePrimitive
          def value_to_binary_string(value)
            raise NotImplementedError
          end
          def read_and_return_value(io)
            config = io.readbytes(4).unpack("N")[0]
            {
              :raw        => config,
              :bin        => config.to_s(2),
              :_10mb_hd   => config & (1 << 0) != 0,
              :_10mb_fd   => config & (1 << 1) != 0,
              :_100mb_hd  => config & (1 << 2) != 0,
              :_100mb_fd  => config & (1 << 3) != 0,
              :_1gb_hd    => config & (1 << 4) != 0,
              :_1gb_fd    => config & (1 << 5) != 0,
              :_10gb_fd   => config & (1 << 6) != 0,
              :copper     => config & (1 << 7) != 0,
              :fiber      => config & (1 << 8) != 0,
              :autoneg    => config & (1 << 9) != 0,
              :pause      => config & (1 << 10) != 0,
              :pause_asym => config & (1 << 11) != 0
            }
          end

          def sensible_default
            {
              :_10mb_hd   => false,
              :_10mb_fd   => false,
              :_100mb_hd  => false,
              :_100mb_fd  => false,
              :_1gb_hd    => false,
              :_1gb_fd    => false,
              :_10gb_fd   => false,
              :copper     => false,
              :fiber      => false,
              :autoneg    => false,
              :pause      => false,
              :pause_asym => false
            }
          end
        end # class::PortFeatures < BinData::BasePrimitive

      end # class::Port
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
