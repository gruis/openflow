class OpenFlow
  module Proto
    module V0x01
      class Message
        class PacketIn
          include Base

          class Record < BinData::Record
            endian :big
            uint32 :buffer_id
            uint16 :total_len
            uint16 :in_port
            uint8 :reason
            uint8 :pad
            string :data, :read_length => :total_len
          end # class::Record < BinData::Record

          def self.read(d)
            record = Record.read(d)
            o = allocate
            o.from_record(record)
          end

          REASON = [
            :no_match,
            :action
          ]

          attr_reader :buffer_id, :length, :in_port, :reason, :pad, :data

          def from_record(record)
            @buffer_id = record.buffer_id
            @length    = record.total_len
            # TODO parse the port
            @in_port   = record.in_port
            @reason    = REASON[record.reason]
            @pad       = record.pad
            @data      = record.data
            self
          end
        end # class::PacketIn
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
