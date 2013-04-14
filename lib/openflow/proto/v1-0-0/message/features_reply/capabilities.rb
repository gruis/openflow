class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply < BinData::Record
          class FeaturesReplyCapabilities < BinData::BasePrimitive

            def value_to_binary_string(value)
              raise NotImplementedError
            end

            def sensible_default
              {
                :flow_stats   => false,
                :table_stats  => false,
                :port_stats   => false,
                :stp          => false,
                :reserved     => false,
                :ip_reasm     => false,
                :queue_stats  => false,
                :arp_match_ip => false
              }
            end

            def read_and_return_value(io)
              config = io.readbytes(4).unpack("N")[0]
              {
                :value        => config,
                :bin          => config.to_s(2),
                :flow_stats   => config & (1 << 0) != 0,
                :table_stats  => config & (1 << 1) != 0,
                :port_stats   => config & (1 << 2) != 0,
                :stp          => config & (1 << 3) != 0,
                :reserved     => config & (1 << 4) != 0,
                :ip_reasm     => config & (1 << 5) != 0,
                :queue_stats  => config & (1 << 6) != 0,
                :arp_match_ip => config & (1 << 7) != 0
              }
            end
          end # class::FeaturesReplyCapabilities < BinData::Record
        end # class::FeaturesReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
