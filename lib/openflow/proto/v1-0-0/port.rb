require "openflow/mac-addr"
Dir[File.expand_path("../port/", __FILE__) + "**/*.rb"].each do |f|
  require f
end

class OpenFlow
  module Proto
    module V0x01
      class Port < BinData::Record

        endian :big
        uint16 :port_no
        mac_addr :hw_addr
        string :name, :read_length => 16, :trim_padding => true

        port_config :config
        port_state :state

        # Current features
        port_features :curr
        # Features advertised by the port
        port_features :advertised
        # Features supported by the port
        port_features :supported
        # Features advertised by the peer
        port_features :peer


      end # class::Port
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
