require File.expand_path("../header/type", __FILE__)
class OpenFlow
  module Proto
    module V0x01
      class Message
        class Header < BinData::Record

          endian :big
          uint8 :version
          header_type :type
          uint16 :len
          uint32 :xid

        end # class::Header
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
