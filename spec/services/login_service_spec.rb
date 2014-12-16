require "rails_helper"

RSpec.describe LoginService do
  let(:attributes) do
    { identification: credential.identification, password: password }
  end
  let(:credential) { create :credential, password: password }
  let(:password) { "password" }
  let(:service) { described_class.new attributes }

  describe "#create_key" do
    before {}

    it "should create a key" do
      expect { service.create_key }.to change { Key.count }.by 1
    end

    it "should create a key belonging to credential" do
      service.create_key
      expect(credential.keys).to include Key.first
    end

    it "should return a response" do
      expect(service.create_key).not_to be_nil
    end
  end

  describe "#process" do
    context "when valid" do
      it "should receive :create_key message" do
        expect(service).to receive :create_key
        service.process
      end
    end

    context "when not valid" do
      let(:attributes) do
        { identification: "", password: "" }
      end

      it "should not receive :create_key message" do
        expect(service).not_to receive :create_key
        service.process
      end
    end
  end

  describe "#record" do
    it "should return the same credential" do
      expect(service.record).to eq credential
    end
  end

  describe "#valid?" do
    context "when credential can be found" do
      context "when password is correct" do
        it "should return true" do
          expect(service.valid?).to be true
        end
      end

      context "when password is not correct" do
        let(:attributes) do
          { identification: credential.identification, password: "" }
        end

        it "should return false" do
          expect(service.valid?).to be false
        end
      end
    end

    context "when credential cannot be found" do
      let(:attributes) do
        { identification: "", password: password }
      end

      it "should return false" do
        expect(service.valid?).to be false
      end
    end
  end
end
