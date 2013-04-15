require "bindata"

class OpenFlow
  class Bitmask < BinData::BasePrimitive

    mandatory_parameter :type
    mandatory_parameter :flags

    class << self
      def sanitize_parameters!(params)
        if params.needs_sanitizing?(:type)
          el_type, el_params = params[:type]
          params[:type] = params.create_sanitized_object_prototype(el_type, el_params)
        end
      end
    end

    def initialize_shared_instance
      @ele_proto      = get_parameter(:type)
      @ele_proto_inst = @ele_proto.instantiate(nil, self)
    end

    def sensible_default
      Hash[flags.map{|k,v| [k,false]}]
    end

    def read_and_return_value(io)
      # FIXME follow the pattern used by BinData::Array
      bits = @ele_proto_inst.class.read(io)
      values = {:mask => bits}
      flags.each do |flag|
        values[flag] = (bits & mask(flag)) > 0
      end
      values
    end

    def value_to_binary_string(value)
      bits = 0
      flags.each do |flag,enable|
        next unless enable
        raise ArgumentError.new("#{flag.inspect} is not a recognized flag") unless flags.include?(flag)
        bits |= mask(cap)
      end
      new_element(bits).to_binary_s
    end

    private

    def flags
      return @bitmask_flags if @bitmask_flags
      f = eval_parameter(:flags)
      @bitmask_flags = f.is_a?(Hash) ? f.keys : f
    end

    def mask(flag)
      flags_param = eval_parameter(:flags)
      flags_param.is_a?(Hash) ? flags_param[flag] : 2**flags_param.index(flag)
    end

    def new_element(value = nil)
      @ele_proto.instantiate(value, self)
    end
  end # class::Enum < BinData::BasePrimitive
end # class::OpenFlow

