class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply
          include Base

          class Record < BinData::Record
            endian :big
            uint64 :datapath_id
            uint32 :n_buffers
            uint8 :n_tables
            uint32 :pad
            uint32 :capabilities
            uint32 :actions
            rest :ports
          end # class::Record < BinData::Record

          class Capabilities < BinData::Record
            endian :big
            bit1 :flow_stats
            bit2 :table_stats
            bit3 :port_stats
            bit4 :stp
            bit5 :reserved
            bit6 :ip_reasm
            bit7 :queue_stats
            bit8 :arp_match_ip
          end

          def self.read(d)
            record = Record.read(d)
            o = allocate
            o.from_record(record)
          end

          attr_reader :datapath_id, :buffers, :tables, :pad, :capabilities, :actions, :ports

          def from_record(record)
            # TODO convert lower 48-bits to MAC address
            @datapath_id = record.datapath_id
            @buffers     = record.n_buffers
            @tables      = record.n_tables
            @pad         = record.pad
            # TODO convert bitmask with bitshift ops
            caps = record.capabilities.to_i.to_s(2)
            @capabilities = {
              :flow_stats   => caps[0] == "1",
              :table_stats  => caps[1] == "1",
              :port_stats   => caps[2] == "1",
              :stp          => caps[3] == "1",
              :reserved     => caps[4] == "1",
              :ip_reasm     => caps[5] == "1",
              :queue_stats  => caps[6] == "1",
              :arp_match_ip => caps[7] == "1"
            }
            # TODO convert bitmask with bitshift ops
            actions = record.actions.to_i.to_s(2)
            @actions      = {
              :set_vlan_id    => actions[0] == "1",
              :set_vlan_pri   => actions[1] == "1",
              :strip_vlan_hdr => actions[2] == "1",
              :mod_ethr_src   => actions[3] == "1",
              :mod_ethr_dst   => actions[4] == "1",
              :mod_ipv4_src   => actions[5] == "1",
              :mod_ipv4_dst   => actions[6] == "1",
              :mod_ipv4_tos   => actions[7] == "1",
              :mod_trns_src   => actions[8] == "1",
              :mod_trns_dst   => actions[9] == "1",
            }
            # TODO parse ports
            @ports        = record.ports
            self
          end

        end # class::FeaturesReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

