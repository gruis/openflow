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
            t = type.intern
            unless @types.include?(t)
              raise NotImplementedError.new("Unsupported message type #{t.inspect}; #{@types.keys}")
            end
            @types[t].read(body)
          end
        end # class << self

      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

Dir[File.expand_path("../message/*.rb", __FILE__)].each do |f|
  require f
end
