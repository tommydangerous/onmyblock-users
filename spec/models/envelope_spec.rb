require_relative "../../app/models/envelope"

RSpec.describe Envelope do
  let(:options) { {} }
  subject { described_class.new options }

  it { should respond_to :errors }
  it { should respond_to :metadata }
  it { should respond_to :resource }

  describe "#add_metadata" do
    before { subject.add_metadata options }

    it "should have an execution time in metadata" do
      expect(subject.metadata[:execution_time]).not_to be_nil
    end

    context "when status is in the options" do
      let(:options) { { status: status } }
      let(:status)  { 200 }

      it "should have a status in metadata" do
        expect(subject.metadata[:status]).to eq status
      end
    end
  end
end
