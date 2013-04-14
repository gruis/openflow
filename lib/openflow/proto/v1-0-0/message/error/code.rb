class OpenFlow
  module Proto
    module V0x01
      class Message
        class Error < BinData::Record
          class ErrorCode < BinData::BasePrimitive

            CODES = {
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


            def sensible_default
              nil
            end

            def read_and_return_value(io)
              code = io.readbytes(2).unpack("n")[0]
              CODES[eval_parameter(:type).intern][code]
            end

            def value_to_binary_string(value)
              [CODES[eval_parameter(:type).intern].index(value)].pack("n")
            end

          end # class::Type < BinData::Primitive
        end # class::Error
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow

