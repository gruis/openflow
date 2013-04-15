require "openflow/proto/v1-0-0/message/error/code"

class OpenFlow
  module Proto
    module V0x01
      class Message
        class Error < BinData::Record
          include Base

          TYPES = [
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

          endian :big
          enum :type, :type => :uint16, :values => TYPES
          error_code :code, :type => :type
          rest :data

        end # class::Error
      end # class::Message
    end # module::V0x01
  end # module::Proto
end # class::OpenFlow
