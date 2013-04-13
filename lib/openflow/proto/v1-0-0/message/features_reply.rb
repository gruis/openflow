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

          def self.read(d)
            record = Record.read(d)
            o = allocate
            o.from_record(record)
          end

          attr_reader :datapath_id, :buffers, :tables, :pad, :capabilities, :actions, :ports

          def from_record(record)
            # TODO seperate lower 48 bits from upper 16 bits
            @datapath_id = record.datapath_id.to_i.to_s(16)
            @buffers     = record.n_buffers
            @tables      = record.n_tables
            @pad         = record.pad
            @capabilities = {
              :flow_stats   => record.capabilities & 0b1000000000000000 != 0,
              :table_stats  => record.capabilities & 0b100000000000000 != 0,
              :port_stats   => record.capabilities & 0b10000000000000 != 0,
              :stp          => record.capabilities & 0b1000000000000 != 0,
              :reserved     => record.capabilities & 0b100000000000 != 0,
              :ip_reasm     => record.capabilities & 0b10000000000 != 0,
              :queue_stats  => record.capabilities & 0b1000000000 != 0,
              :arp_match_ip => record.capabilities & 0b100000000 != 0
            }
            @actions      = {
              :set_vlan_id    => record.actions & 0b100000000000000000 != 0,
              :set_vlan_pri   => record.actions & 0b10000000000000000 != 0,
              :strip_vlan_hdr => record.actions & 0b1000000000000000 != 0,
              :mod_ethr_src   => record.actions & 0b100000000000000 != 0,
              :mod_ethr_dst   => record.actions & 0b10000000000000 != 0,
              :mod_ipv4_src   => record.actions & 0b1000000000000 != 0,
              :mod_ipv4_dst   => record.actions & 0b100000000000 != 0,
              :mod_ipv4_tos   => record.actions & 0b10000000000 != 0,
              :mod_trns_src   => record.actions & 0b1000000000 != 0,
              :mod_trns_dst   => record.actions & 0b100000000 != 0
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

