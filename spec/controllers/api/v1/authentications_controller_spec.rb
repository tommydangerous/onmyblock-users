require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController do
  describe "POST #login" do
    let(:credential) do
      create :credential, identification: user.email,
                          password:       password,
                          user:           user
    end
    let(:login_password) { password }
    let(:password) { "password" }
    let(:user) { create :user }

    before do
      post :login, identification: credential.identification,
                   password: login_password
    end

    context "with valid identification and password" do
      it "should return status 201" do
        expect(response.status).to eq 201
      end

      it "should create a key" do
        expect(Key.count).to eq 1
      end

      it "should return token" do
        expect(response.body).to match credential.keys.first.token
      end
    end

    context "with invalid password" do
      let(:login_password) { "" }

      it "should return status 422" do
        expect(response.status).to eq 422
      end

      it "should not create a key" do
        expect(Key.count).to eq 0
      end
    end
  end

  describe "DELETE #logout" do
    let(:key) { create :key }

    before do
      api_token key.token
      delete :logout
    end

    it "should return status 200" do
      expect(response.status).to eq 200
    end

    it "should destroy the key" do
      expect(Key.count).to eq 0
    end
  end
end
