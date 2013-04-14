class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply < BinData::Record
          class FeaturesReplyActions < BinData::BasePrimitive

            def value_to_binary_string(value)
              raise NotImplementedError
            end

            def sensible_default
              {
                :set_vlan_id    => false,
                :set_vlan_pri   => false,
                :strip_vlan_hdr => false,
                :mod_ethr_src   => false,
                :mod_ethr_dst   => false,
                :mod_ipv4_src   => false,
                :mod_ipv4_dst   => false,
                :mod_ipv4_tos   => false,
                :mod_trns_src   => false,
                :mod_trns_dst   => false
              }
            end

            def read_and_return_value(io)
              config = io.readbytes(4).unpack("N")[0]
              {
                :value          => config,
                :bin            => config.to_s(2),
                :set_vlan_id    => config & (1 << 1) != 0,
                :set_vlan_pri   => config & (1 << 2) != 0,
                :strip_vlan_hdr => config & (1 << 3) != 0,
                :mod_ethr_src   => config & (1 << 4) != 0,
                :mod_ethr_dst   => config & (1 << 5) != 0,
                :mod_ipv4_src   => config & (1 << 6) != 0,
                :mod_ipv4_dst   => config & (1 << 7) != 0,
                :mod_ipv4_tos   => config & (1 << 8) != 0,
                :mod_trns_src   => config & (1 << 9) != 0,
                :mod_trns_dst   => config & (1 << 10) != 0
              }
            end
          end # class::FeaturesReplyActions < BinData::Record
        end # class::FeaturesReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
