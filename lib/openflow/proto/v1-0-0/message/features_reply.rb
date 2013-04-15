require "openflow/proto/datapath-id"
require "openflow/proto/v1-0-0/port"

class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply < BinData::Record
          include Base

          CAPABILITIES = [
            :flow_stats,
            :table_stats,
            :port_stats,
            :stp,
            :reserved,
            :ip_reasm,
            :queue_stats,
            :arp_match_ip,
          ]

          ACTIONS = [
            :set_vlan_id,
            :set_vlan_pri,
            :strip_vlan_hdr,
            :mod_ethr_src,
            :mod_ethr_dst,
            :mod_ipv4_src,
            :mod_ipv4_dst,
            :mod_ipv4_tos,
            :mod_trns_src,
            :mod_trns_dst
          ]

          endian :big
          datapath_id :datapath_id
          uint32 :n_buffers
          uint8 :n_tables
          array :pad, :type => :uint8, :initial_length => 3
          bitmask :capabilities, :type => :uint32, :flags => CAPABILITIES
          bitmask :actions, :type => :uint32, :flags => ACTIONS
          array :ports, :type => :port, :read_until => :eof

        end # class::FeaturesReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
