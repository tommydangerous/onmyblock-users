require_relative "../../app/services/crud_service"

RSpec.describe CrudService do
  subject { described_class.new model, options, serializer }

  let(:model)      { double "model" }
  let(:options)    { double "options" }
  let(:serializer) { nil }

  it { should respond_to :response }
  it { should respond_to :status }

  describe "#process" do
    context "with a condition" do
      it "should not send :record_action message" do
        expect(subject).not_to receive :record_action
        subject.process "some condition"
      end

      context "that is true" do
        let(:condition) { true }

        it "should send :success_response message" do
          expect(subject).to receive :success_response
          subject.process condition
        end

        it "should send :success_status message" do
          expect(subject).to receive :success_status
          subject.process condition
        end

        it "should receive :serialized_record message" do
          expect(subject).to receive :serialized_record
          subject.process condition
        end

        it "should not send :failure_response message" do
          expect(subject).not_to receive :failure_response
          subject.process condition
        end

        it "should not send :failure_status message" do
          expect(subject).not_to receive :failure_status
          subject.process condition
        end

        it "should return with a status of 200  " do
          subject.process condition
          expect(subject.status).to eq 200  
        end
      end

      context "that is false" do
        let(:condition) { false }

        it "should not send :success_response message" do
          expect(subject).not_to receive :success_response
          subject.process condition
        end

        it "should not send :success_status message" do
          expect(subject).not_to receive :success_status
          subject.process condition
        end

        it "should send :failure_response message" do
          expect(subject).to receive :failure_response
          subject.process condition
        end

        it "should send :failure_status message" do
          expect(subject).to receive :failure_status
          subject.process condition
        end

        it "should return with a status of 400" do
          subject.process condition
          expect(subject.status).to eq 400
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
end
