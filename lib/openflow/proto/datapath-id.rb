class OpenFlow
  module Proto
    class DatapathId < BinData::BasePrimitive
      def value_to_binary_string(value)
        raise NotImplementedError
      end

      def read_and_return_value(io)
        a, b = io.readbytes(8).unpack("NN")
        val = a + b
        val.to_s(16)
      end

      def sensible_default
        ""
      end

    end # class::MacAddr < BinData::BasePrimitive
  end # module::Proto
end # class::OpenFlow
