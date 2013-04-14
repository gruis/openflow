require "openflow/proto/datapath-id"
require "openflow/proto/v1-0-0/port"
Dir[File.join(File.expand_path("../features_reply", __FILE__), "**/*.rb")].each do |f|
  require f
end

class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply < BinData::Record
          include Base

          endian :big
          uint64 :datapath_id
          # TODO build datapath id type
          #    @datapath_id  = record.datapath_id.to_i.to_s(16)
          #datapath_id :datapath_id
          uint32 :n_buffers
          uint8 :n_tables
          array :pad, :type => :uint8, :initial_length => 3
          features_reply_capabilities :capabilities
          features_reply_actions :actions
          array :ports, :type => :port, :read_until => :eof

        end # class::FeaturesReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

