require File.expand_path("../spec_helper", __FILE__)
require "openflow/proto"


class OpenFlow
  module Proto
    module V0x23A
      include Proto
    end
  end
end


describe OpenFlow::Proto do
  it { should respond_to(:protos) }

  describe "#protos" do
    subject { described_class.protos }
    it { should be_a Array }
    it "should have only unique versions" do
      subject.map(&:version).uniq == subject.map(&:version)
    end
  end

  describe "#module_for_version" do
    context "client version is higher than #max_version" do
      it "should return the highest local version" do
        OpenFlow::Proto.module_for_version(0x23B).should_not be_nil
        OpenFlow::Proto.module_for_version(0x23B).version.should == OpenFlow::Proto.max_version
      end
    end
    context "client version is lower than #max_version" do
      it "should return the version equal to the client version" do
        OpenFlow::Proto.module_for_version(1).should_not be_nil
        OpenFlow::Proto.module_for_version(1).version.should == 1
      end
    end
  end

end

describe OpenFlow::Proto::V0x01 do
  it_behaves_like "an ovf protocol"
end

# Fake protocol version
describe OpenFlow::Proto::V0x23A do
  it_behaves_like "an ovf protocol"
end
