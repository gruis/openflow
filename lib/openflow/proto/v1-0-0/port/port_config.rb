class OpenFlow
  module Proto
    module V0x01
      class Port < BinData::Record

        class PortConfig < BinData::BasePrimitive
          def value_to_binary_string(value)
            raise NotImplementedError
          end
          def read_and_return_value(io)
            config = io.readbytes(4).unpack("N")[0]
            {
              :raw          => config,
              :port_down    => config & (1 << 0) != 0,
              :no_stp       => config & (1 << 1) != 0,
              :no_recv      => config & (1 << 2) != 0,
              :no_recv_stp  => config & (1 << 3) != 0,
              :no_flood     => config & (1 << 4) != 0,
              :no_fwd       => config & (1 << 5) != 0,
              :no_packet_in => config & (1 << 6) != 0
            }
          end

          def sensible_default
            {
              :port_down    => false,
              :no_stp       => false,
              :no_recv      => false,
              :no_recv_stp  => false,
              :no_flood     => false,
              :no_fwd       => false,
              :no_packet_in => false
            }
          end
        end # class::PortConfig < BinData::BasePrimitive

      end # class::Port
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
