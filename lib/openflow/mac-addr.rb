class OpenFlow
  class MacAddr < BinData::BasePrimitive

    def octets
      return @octets if @octets
      value.split(":").map{|o| Integer("0x#{o}") }
    end

    def value_to_binary_string(value)
      octets = value.split(":").map{|o| Integer("0x#{o}") }
      octets.pack("CCCCCC")
    end

    def read_and_return_value(io)
      uint48 = io.readbytes(6)
      @octets = uint48.unpack("CCCCCC")
      @octets.map{|o| "%02x" % o }.join(":")
    end

    def sensible_default
      ""
    end

  end # class::MacAddr < BinData::BasePrimitive
end # class::OpenFlow
