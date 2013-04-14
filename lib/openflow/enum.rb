require "bindata"

class OpenFlow
  class Enum < BinData::BasePrimitive

    mandatory_parameter :type
    mandatory_parameter :values

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
      nil
    end

    def read_and_return_value(io)
      # FIXME follow the pattern used by BinData::Array
      type = @ele_proto_inst.class.read(io)
      eval_parameter(:values)[type]
    end

    def value_to_binary_string(value)
      idx = eval_parameter(:values).index(value)
      raise ArgumentError.new("key #{value} not found in enumeration") unless idx
      new_element(idx).to_binary_s
    end

    private

    def new_element(value = nil)
      @ele_proto.instantiate(value, self)
    end
  end # class::Enum < BinData::BasePrimitive
end # class::OpenFlow
