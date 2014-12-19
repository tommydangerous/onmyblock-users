require "rails_helper"

RSpec.describe Api::V1::CredentialsController do
  let(:credential)    { key.credential }
  let(:credential_id) { credential.id }
  let(:key)           { create :key }

  describe "PUT/PATCH #update" do
    before { put :update, id: credential_id, token: key.token }

    context "when credential is found" do
      it "should update the credential's confirmed_at" do
        expect(Credential.find(credential.id).confirmed_at).not_to be_nil
      end

      it "should return status 200" do
        expect(envelope_status).to eq 200
      end
    end

    context "when credential is found" do
      let(:credential_id) { "0" }

      it "should update the credential's confirmed_at" do
        expect(Credential.find(credential.id).confirmed_at).to be_nil
      end

      it "should return status 304" do
        expect(envelope_status).to eq 304
      end
    end
  end
end
