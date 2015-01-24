require "rails_helper"

RSpec.describe Api::V1::CredentialUpdateFromResetsController do
  describe "POST #create" do
    let(:credential_reset) { create :credential_reset }
    let(:parameters)       { { password: password, token: token } }
    let(:password)         { "password" }
    let(:token)            { credential_reset.token }

    before { post :create, parameters }

    context "with valid parameters" do
      it "should return status 201" do
        expect(response.status).to eq 201
      end
    end

    context "with invalid parameters" do
      let(:token) { "" }

      it "should return status 422" do
        expect(response.status).to eq 422
      end
    end
  end
end
