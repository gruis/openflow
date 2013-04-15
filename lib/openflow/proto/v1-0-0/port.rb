require "openflow/mac-addr"

class OpenFlow
  module Proto
    module V0x01
      class Port < BinData::Record

        CONFIG = [
          :port_down,
          :no_stp,
          :no_recv,
          :no_recv_stp,
          :no_flood,
          :no_fwd,
          :no_packet_in
        ]

        FEATURES = [
          :_10mb_hd,
          :_10mb_fd,
          :_100mb_hd,
          :_100mb_fd,
          :_1gb_hd,
          :_1gb_fd,
          :_10gb_fd,
          :copper,
          :fiber,
          :autoneg,
          :pause,
          :pause_asym
        ]

        STATES = {
          :link_down   => (1 << 0),
          :stp_listen  => (0 << 8),
          :stp_learn   => (1 << 8),
          :stp_forward => (2 << 8),
          :stp_block   => (3 << 8),
          :stp_mask    => 3 << 8
        }

        endian :big
        uint16 :port_no
        mac_addr :hw_addr
        string :name, :read_length => 16, :trim_padding => true

        bitmask :config, :type => :uint32, :flags => CONFIG
        bitmask :state, :type => :uint32, :flags => STATES

        # Current features
        bitmask :curr, :type => :uint32, :flags => FEATURES
        # Features advertised by the port
        bitmask :advertised, :type => :uint32, :flags => FEATURES
        # Features supported by the port
        bitmask :supported, :type => :uint32, :flags => FEATURES
        # Features advertised by the peer
        bitmask :peer, :type => :uint32, :flags => FEATURES

      end # class::Port
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
