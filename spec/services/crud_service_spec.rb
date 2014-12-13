require_relative "../../app/services/crud_service"

RSpec.describe CrudService do
  subject { described_class.new model, options }

  let(:model)   { double "model" }
  let(:options) { double "options" }

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

        it "should not send :failure_response message" do
          expect(subject).not_to receive :failure_response
          subject.process condition
        end

        it "should not send :failure_status message" do
          expect(subject).not_to receive :failure_status
          subject.process condition
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
      end
    end

    context "without a condition" do
      it "should send :record_action message" do
        expect(subject).to receive :record_action
        subject.process
      end
    end
  end
end
