class OpenFlow
  module Proto
    module V0x01
      class Message
        class PacketIn < BinData::Record
          include Base

          endian :big
          uint32 :buffer_id
          uint16 :total_len
          uint16 :in_port
          enum :reason, :type => :uint8, :values => [:no_match, :action]
          uint8 :pad
          string :data, :read_length => :total_len

        end # class::PacketIn
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
