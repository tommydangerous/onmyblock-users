require "rails_helper"

RSpec.describe ApiController do
  let(:controller) { described_class.new }

  describe "#delete_service" do
    it "should receive :service message" do
      expect(controller).to receive :service
      controller.send :delete_service, Class, {}
    end
  end

  describe "#package_envelope" do
    let(:condition) { true }
    let(:hash)      { controller.send :package_envelope, service, 200, 404 }
    let(:service)   { double "service", process: condition, response: {} }

    context "when service process is true" do
      it "should return a hash with key errors" do
        expect(hash).to have_key :errors
      end

      it "should return a hash with key resource" do
        expect(hash).to have_key :resource
      end

      it "should return a hash with key status" do
        expect(hash).to have_key :status
      end
    end

    context "when service process is false" do
      let(:condition) { false }

      it "should return a hash with key errors" do
        expect(hash).to have_key :errors
      end

      it "should return a hash with key resource" do
        expect(hash).to have_key :resource
      end

      it "should return a hash with key status" do
        expect(hash).to have_key :status
      end
    end
  end

  describe "#render_envelope" do
    it "should create a new Envelope" do
      allow(controller).to receive(:render)
      expect(Envelope).to receive :new
      controller.send :render_envelope, {}
    end
  end

  describe "#service" do
    it "should set an instance variable" do
      expect(controller.send :service, "create", Class, {}, nil).not_to be_nil
    end
  end
end
