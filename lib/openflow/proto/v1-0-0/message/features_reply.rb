require "openflow/proto/datapath-id"
require "openflow/proto/v1-0-0/port"
require "openflow/proto/v1-0-0/message/features_reply/actions"
require "openflow/proto/v1-0-0/message/features_reply/capabilities"

class OpenFlow
  module Proto
    module V0x01
      class Message
        class FeaturesReply < BinData::Record
          include Base

          endian :big
          datapath_id :datapath_id
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
