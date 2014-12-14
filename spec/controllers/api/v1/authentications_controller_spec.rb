require "rails_helper"

RSpec.describe Api::V1::AuthenticationsController do
  describe "POST #create" do
    let(:credential) {
      create :credential, identification: user.email, password: password
    }
    let(:password) { "password" }
    let(:user) { create :user }

    before(:each) do
      post :create, {
        authentication: { 
          identification: user.email, password: password
        }
      }
    end

    it "should return a response" do
      expect(response.body).not_to be_nil
    end

    it "should return a status" do
      expect(response.status).not_to be_nil
    end
  end

  describe "DELETE #logout" do
    let(:key) { create :key }

    before { delete :logout, { token: key.token } }

    it "should return a response" do
      expect(response.body).not_to be_nil
    end

    it "should return a status" do
      expect(response.status).not_to be_nil
    end
  end
end
