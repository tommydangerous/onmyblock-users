require "rails_helper"

RSpec.describe Keyable do
  let(:key) { create :key }
  let(:model) do
    Class.new.class_exec described_class do |mod|
      include mod

      def initialize(options)
        @options = options
      end

      attr_private :options
    end
  end
  let(:options) { { token: key.token } }
  let(:service) { model.new options }

  describe "#key" do
    context "with a correct token" do
      it "should return a key" do
        expect(service.key).to eq key
      end
    end

    context "with an incorrect token" do
      let(:options) { { token: "" } }

      it "should return nil" do
        expect(service.key).to be_nil
      end
    end
  end
end
