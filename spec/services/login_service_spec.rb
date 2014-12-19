require "rails_helper"

RSpec.describe LoginService do
  let(:attributes) do
    { identification: credential.identification, password: password }
  end
  let(:credential) { create :credential, password: password }
  let(:password) { "password" }
  let(:service) { described_class.new attributes }

  describe "#process" do
    context "with correct password" do
      it "should create a key" do
        expect { service.process }.to change { Key.count }.by 1
      end

      it "should create a key belonging to credential" do
        service.process
        expect(credential.keys).to include Key.first
      end

      it "should have a response" do
        service.process
        expect(service.response).not_to be_nil
      end
    end

    context "with incorrect password" do
      let(:attributes) { { password: "" } }

      before { service.process }

      it "should not create a key" do
        expect(Key.count).to eq 0
      end

      it "should have a response with errors" do
        expect(service.response).to have_key :authentication_failed
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
          expect(service.send :valid?).to be true
        end
      end

      context "when password is not correct" do
        let(:attributes) do
          { identification: credential.identification, password: "" }
        end

        it "should return false" do
          expect(service.send :valid?).to be false
        end
      end
    end

    context "when credential cannot be found" do
      let(:attributes) do
        { identification: "", password: password }
      end

      it "should return false" do
        expect(service.send :valid?).to be false
      end
    end
  end
end
