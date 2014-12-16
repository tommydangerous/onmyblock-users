require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController do
  describe "POST #login" do
    let(:credential) do
      create :credential, identification: user.email, password: password
    end
    let(:password) { "password" }
    let(:user) { create :user }

    before { post :login, identification: user.email, password: password }

    it "should return a response" do
      expect(response.body).not_to be_nil
    end

    it "should return a status" do
      expect(response.status).not_to be_nil
    end
  end

  describe "DELETE #logout" do
    let(:key) { create :key }

    before { delete :logout, token: key.token }

    it "should return a response" do
      expect(response.body).not_to be_nil
    end

    it "should return a status" do
      expect(response.status).not_to be_nil
    end
  end
end
