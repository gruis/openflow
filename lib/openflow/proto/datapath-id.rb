class OpenFlow
  module Proto
    class DatapathId < BinData::BasePrimitive

      def value_to_binary_string(value)
        raise NotImplementedError
      end

      def read_and_return_value(io)
        return io.readbytes(8).unpack("H*").first
        # TODO convert only the lower 48 bits to a mac address; take upper 16
        # bits and treate sepertely
        # ---
        # Ruby doesn't have an unpack symbol for big-endian unsigned 64bit
        # integers, so we take to 32bit integers and combine them.
        hi, lo = io.readbytes(8).unpack("NN")
        (hi << 32 | lo).to_s(16)
      end

      def sensible_default
        ""
      end

    end # class::MacAddr < BinData::BasePrimitive
  end # module::Proto
end # class::OpenFlow
