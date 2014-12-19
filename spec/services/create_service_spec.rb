require_relative "../../app/services/create_service"

RSpec.describe CreateService do
  subject { described_class.new model, options, serializer }

  let(:options)    { true }
  let(:serializer) { nil }

  let :model do
    Class.new do
      pattr_initialize :options

      def errors
        "errors"
      end

      def save
        options
      end
    end
  end

  context "with valid attributes" do
    before { subject.process }

    it "should return a model instance" do
      expect(subject.response).to be_a model
    end
  end

  context "with invalid attributes" do
    before { subject.process }

    let(:options) { false }

    it "should return the record's errors" do
      expect(subject.response).to eq "errors"
    end
  end
end
