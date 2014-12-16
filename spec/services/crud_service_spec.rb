require_relative "../../app/services/crud_service"

RSpec.describe CrudService do
  subject { described_class.new model, options, serializer }

  let(:model)      { double "model" }
  let(:options)    { double "options" }
  let(:serializer) { nil }

  it { should respond_to :response }

  describe "#process" do
    it "should receive :set_response" do
      expect(subject).to receive :set_response
      subject.process
    end

    context "with a condition" do
      it "should not send :record_action message" do
        expect(subject).not_to receive :record_action
        subject.process "some condition"
      end

      context "that is true" do
        it "should return true" do
          expect(subject.process true).to be true
        end
      end

      context "that is false" do
        it "should return false" do
          expect(subject.process false).to be false
        end
      end
    end

    context "without a condition" do
      it "should send :record_action message" do
        expect(subject).to receive :record_action
        subject.process
      end
    end
  end

  describe "#record" do
    it "should return nil" do
      expect(subject.record).to be_nil
    end
  end

  describe "#serialized_record" do
    before { subject.process true }

    context "with serializer" do
      let(:serializer) { Struct.new :record }

      it "should return a serialized record" do
        expect(subject.response).to be_a serializer
      end
    end

    context "without serializer" do
      it "should return a record" do
        expect(subject.response).to eq subject.record
      end
    end
  end

  describe "#set_response" do
    context "when condition is true" do
      it "should receive success_response" do
        expect(subject).to receive :success_response
        subject.send :set_response, true
      end
    end

    context "when condition is false" do
      it "should receive failure_response" do
        expect(subject).to receive :failure_response
        subject.send :set_response, false
      end
    end
  end
end
