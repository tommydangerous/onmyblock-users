require "rails_helper"

RSpec.describe ApiController do
  let(:controller) { described_class.new }

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
    let(:action)  { "create" }
    let(:service) { controller.send :service, action, Class, {}, nil }
    it "should set an instance variable" do
      expect(service).not_to be_nil
    end

    context "when action is update" do
      let(:action) { "update" }
      
      it "should return an UpdateService object" do
        expect(service.class).to eq UpdateService
      end
    end
  end
end
