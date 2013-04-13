class OpenFlow
  module Proto
    module V0x01
      class Message
        class Error
          include Base

          TYPE = [
            # Hello protocol failed.
            :hello_failed,
            # Request was not understood.
            :bad_request,
            # Error in action description.
            :bad_action,
            # Problem modifying flow entry.
            :flow_mod_failed,
            # Port mod request failed.
            :port_mod_failed,
            # Queue operation failed.
            :queue_op_failed
          ]

          CODE = {
            :hello_failed => [
              :incompatible,
              :eperm
            ],
            :bad_request => [
              :bad_version,
              :bad_type,
              :bad_stat,
              :bad_vendor,
              :bad_subtype,
              :eperm,
              :bad_len,
              :buffer_empty,
              :buffer_unknown
            ],
            :bad_action => [
              :bad_type,
              :bad_len,
              :bad_vendor,
              :bad_vendor_type,
              :bad_out_port,
              :bad_argument,
              :eperm,
              :too_many,
              :bad_queue
            ],
            :flow_mod_failed => [
              :all_tables_full,
              # attempted to add overlapping flow with CHECK_OVERLAP flag set
              :overlap,
              :eperm,
              # flow not added because of non-zero idle/hard timeout
              :bad_emerg_timeout,
              :bad_command,
              :unsupported
            ],
            :port_mod_failed => [
              :bad_port,
              :bad_hw_addr,
            ],
            :queue_op_failed => [
              :bad_port,
              :bad_queue,
              :eperm
            ]
          }

          class Record < BinData::Record
            endian :big
            uint16 :type
            uint16 :code
            rest :data
          end # class::Record < BinData::Record

          class << self
            def read(d)
              record = Record.read(d)
              o      = allocate
              o.from_record(record)#, data)
              o
            end
          end # class << self

          attr_reader :type, :code, :data

          def initialize(type, code, data)
            unless TYPE.index(type)
              raise ArgumentError.new("#{self.class} type #{type.inspect} not defined")
            end
            unless CODE[type] && CODE[type].index(code)
              raise ArgumentError.new("#{self.class} code #{type}:#{code} not defined")
            end
            @type = type
            @code = code
            @data = data
          end

          def to_binary
            to_record.to_binary_s
          end

          def to_record
            r = Record.new
            r.type = TYPE.index(@type)
            r.code = CODE[@type].index(@code)
            r.data = @data
            r
          end

          def from_record(record)
            @type = TYPE[record.type]
            @code = CODE[@type][record.code]
            @data = record.data
            self
          end

        end # class::Error
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
