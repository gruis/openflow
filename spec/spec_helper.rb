require "bundler/setup"
require "rspec"

shared_examples_for "an ovf protocol" do
  let(:instance) { Object.new.extend(described_class) }

  let(:expected_version_number) { Integer(described_class.to_s.split("::")[-1][1..-1]) }
  it "should have a VERSION constant" do
    described_class.constants.should include(:VERSION)
  end

  it "should have a VERSION constant that matches it's name" do
    constant = described_class.const_get(:VERSION)
    constant.should == expected_version_number
  end

  it { should respond_to(:version) }
  its(:version) { should == expected_version_number }

  context "instnace" do
    subject { instance }
    it { should respond_to(:version) }
    its(:version) { should == expected_version_number }
  end
end
