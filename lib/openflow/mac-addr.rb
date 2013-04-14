class OpenFlow
  class MacAddr < BinData::BasePrimitive
    def value_to_binary_string(value)
      raise NotImplementedError
    end

    def read_and_return_value(io)
      io.readbytes(6).unpack("H2H2H2H2H2H2").join(":")
    end

    def sensible_default
      ""
    end

  end # class::MacAddr < BinData::BasePrimitive
end # class::OpenFlow
