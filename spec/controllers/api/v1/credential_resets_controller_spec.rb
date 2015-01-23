require "rails_helper"

RSpec.describe Api::V1::CredentialResetsController do
  describe "POST #create" do
    let(:attributes)     { { identification: identification } }
    let(:credential)     { create :credential }
    let(:identification) { credential.identification }

    before { post :create, attributes }

    context "with valid attributes" do
      it "should create a credential reset" do
        expect(CredentialReset.count).to eq 1
      end
    end

    context "with invalid attributes" do
      let(:identification) { "" }

      it "should not create a credential reset" do
        expect(CredentialReset.count).to eq 0
      end
    end
  end
end
