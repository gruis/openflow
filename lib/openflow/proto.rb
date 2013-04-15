require "bindata"
require 'openflow/enum'
require 'openflow/bitmask'
require 'openflow/proto/v1-0-0'
require 'openflow/proto/v1-1-0'
require 'openflow/proto/v1-2'
require 'openflow/proto/v1-3-1'

class OpenFlow
  module Proto

    class << self
      def included(c)
        return if c.const_defined?(:VERSION)
        version = Integer(c.to_s.split("::")[-1][1..-1])
        c.instance_variable_set(:@version, version)
        c.send(:define_method, :version) { version }
        c.const_set(:VERSION, version)
        c.class.send(:attr_reader, :version)
      end

      def protos
        Proto.constants.map{|c| Proto.const_get(c) }
          .select{|m| m < Proto }
      end

      def module_for_version(version)
        protos
          .sort { |a,b| b.version <=> a.version }
          .find { |m| m.version <= version }
      end

      def max_version
        protos.sort { |a,b| b.version <=> a.version }.first.version
      end

      def min_version
        protos.sort { |a,b| a.version <=> b.version }.first.version
      end
    end # class << self


    def build_error(type, code, data)
      raise NotImplementedError
    end

    def read_header
      raise NotImplementedError
    end

    def read_body(header)
      raise NotImplementedError
    end

    def build_header(type, version, len, xid)
      raise NotImplementedError
    end

  end # module::Proto
end # class::OpenFlow

# Augment any Protos that were required before Proto
OpenFlow::Proto.protos.each do |p|
  OpenFlow::Proto.included(p)
end
