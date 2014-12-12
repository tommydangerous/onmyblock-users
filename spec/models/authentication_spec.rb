require "rails_helper"

RSpec.describe Authentication do
  let(:attributes) {
    { identification: credential.identification, password: password }
  }
  let(:authentication) { Authentication.new **attributes }
  let(:credential) { create :credential, password: password }
  let(:password) { "password" }

  describe "#credential" do
    it "should return the same credential" do
      expect(authentication.credential).to eq credential
    end
  end

  describe "#valid?" do
    context "when credential can be found" do
      context "when password is correct" do
        it "should return true" do
          expect(authentication.valid?).to be true
        end
      end

      context "when password is not correct" do
        let(:attributes) {
          { identification: credential.identification, password: "" }
        }

        it "should return false" do
          expect(authentication.valid?).to be false
        end
      end
    end

    context "when credential cannot be found" do
      let(:attributes) {
        { identification: "", password: password }
      }

      it "should return false" do
        expect(authentication.valid?).to be false
      end
    end
  end
end
