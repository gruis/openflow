class OpenFlow
  module Proto
    module V0x01
      class SwitchConfig < BinData::Record

        class OfpConfigFlags < BinData::BasePrimitive

          FLAGS = [
            :frag_normal,
            :frag_drop,
            :frag_reason,
            :frag_mask
          ]

          def value_to_binary_string(value)
            flag = FLAGS.index(value.find{|k,v| v }[0]) || 0
            [flag].pack("n")
          end

          def sensible_default
            {
              :frag_normal => false,
              :frag_drop   => false,
              :frag_reasm  => false,
              :frag_mask   => false,
            }
          end

          def read_and_return_value(io)
            {
              FLAGS[io.readbytes(2).unpack("n")[0]] => true
            }
          end
        end # class::OfpConfigFlags < BinData::BasePrimitive

        endian :big
        ofp_config_flags :flags
        uint16 :miss_send_len

      end # class::SwitchConfig
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
