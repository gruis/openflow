require File.expand_path("../spec_helper", __FILE__)
require "bindata"
require "openflow/mac-addr"

class OpenFlow
  module Test

    class MacTestRecord < ::BinData::Record
      mac_addr :mac
    end # class::MacTestRecord < BinData::Record

  end # module::Test
end # class::OpenFlow


describe OpenFlow::MacAddr do
  let :original do
    "3c:07:54:21:24:5c"
  end

  let :octets do
    original.split(":").map{|o| Integer("0x#{o}") }
  end

  let :binary do
    octets.pack("CCCCCC")
  end

  let :io do
    StringIO.new(binary).tap { |s| s.rewind }
  end

  subject { OpenFlow::Test::MacTestRecord.read(io).mac }

  it "read mac addresses encoded as 6 bytes" do
    OpenFlow::Test::MacTestRecord.read(io).mac.should == original
  end

  it { should be_a OpenFlow::MacAddr }
  it "should have 5 ':' seperators" do
    subject.count(":").should == 5
  end

  it { should respond_to :octets }
  its(:octets) { should be_an Array }
  its(:octets) { should have(6).items }
  its(:octets) { should == octets }

  describe "locally created MacAddr" do
    let(:record) { OpenFlow::Test::MacTestRecord.new(:mac => original ) }
    subject { record.mac }

    it { should be_a OpenFlow::MacAddr }
    it { should respond_to :octets }
    its(:octets) { should == octets }
    context "writing" do
      it "should correctly encode to binary" do
        record.to_binary_s.should == binary
      end
      it "should be 6 bytes" do
        record.to_binary_s.length.should == 6
      end
    end
  end
end
