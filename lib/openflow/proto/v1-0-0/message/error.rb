Dir[File.join(File.expand_path("../", __FILE__), "**/*.rb")].each do |f|
  require f
end

class OpenFlow
  module Proto
    module V0x01
      class Message
        class Error < BinData::Record
          include Base

          endian :big
          error_type :type
          error_code :code, :type => :type
          rest :data

        end # class::Error
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
