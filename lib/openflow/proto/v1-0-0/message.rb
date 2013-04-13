class OpenFlow
  module Proto
    module V0x01

      class Message
        def initialize(header, body = nil)
          @header = header
          @body   = body
        end

        class << self
          def register(type, klass)
            @types ||= {}
            @types[type] = klass
          end

          def parse(type, body)
            raise NotImplementedError.new("Unsupported message type #{type.inspect}") unless @types[type]
            @types[type].read(body)
          end
        end # class << self

      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

require "openflow/proto/v1-0-0/message/base"
require "openflow/proto/v1-0-0/message/header"
require "openflow/proto/v1-0-0/message/error"
require "openflow/proto/v1-0-0/message/packet_in"
