class OpenFlow
  module Proto
    module V0x01
      class Message
        module Base
          def self.included(c)
            name = "#{c}".split("::")[-1]
                      .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
                      .gsub(/([a-z\d])([A-Z])/,'\1_\2')
                      .tr("-", "_")
                      .downcase
                      .intern
            Message.register(name, c)
          end
        end # module::Base
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
