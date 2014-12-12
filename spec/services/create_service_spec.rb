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

  it { should respond_to :record }

  describe "#process" do
    context "with a condition" do
      it "should not send :save message to record" do
        expect(subject.record).not_to receive :save
        subject.process "some condition"
      end

      context "that is true" do
        it "should send :serialized_record message" do
          expect(subject).to receive :serialized_record
          subject.process true
        end
      end

      context "that is false" do
        it "should not send :serialized_record message" do
          expect(subject).not_to receive :serialized_record
          subject.process false
        end
      end
    end

    context "without a condition" do
      it "should send :save message to record" do
        expect(subject.record).to receive :save
        subject.process
      end
    end
  end

  context "with valid attributes" do
    before { subject.process }

    it "should set status to 201" do
      expect(subject.status).to eq 201
    end

    it "should return a model instance" do
      expect(subject.response).to be_a model
    end
  end

  context "with invalid attributes" do
    before { subject.process }

    let(:options) { false }

    it "should set status to 201" do
      expect(subject.status).to eq 422
    end

    it "should return the record's errors" do
      expect(subject.response).to eq "errors"
    end
  end

  context "with a serializer" do
    before { subject.process }

    let(:serializer) { Struct.new :record }

    it "should set status to 201" do
      expect(subject.status).to eq 201
    end

    it "should return a model instance" do
      expect(subject.response).to be_a serializer
    end
  end
end
