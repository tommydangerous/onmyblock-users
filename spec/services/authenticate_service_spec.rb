require "rails_helper"

RSpec.describe AuthenticateService do
  let(:key) { create :key }
  let(:options) { { token: key.token } }
  let(:block) { nil }
  let(:service) { described_class.new options, block }

  describe "#process" do
    context "when key is found" do
      context "when key did not expire" do
        it "should receive callback" do
          expect(service).to receive :callback
          service.process
        end

        context "with a block" do
          let(:block) { proc { |_obj| block_return } }
          let(:block_return) { "block_return" }

          it "should return a key object" do
            service.process
            expect(service.response).to eq block_return
          end
        end

        context "without a block" do
          it "should return a key" do
            service.process
            expect(service.response).to eq key
          end
        end
      end

      context "when key did expire" do
        let(:options) { { token: "" } }

        it "should not receive callback" do
          expect(service).not_to receive :callback
          service.process
        end
      end
    end
  end
end
