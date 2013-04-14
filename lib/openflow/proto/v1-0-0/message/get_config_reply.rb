require "openflow/proto/v1-0-0/switch-config"

class OpenFlow
  module Proto
    module V0x01
      class Message
        class GetConfigReply < SwitchConfig
          include Base

        end # class::GetConfigReply
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
