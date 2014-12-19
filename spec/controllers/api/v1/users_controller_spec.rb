require "rails_helper"

RSpec.describe Api::V1::UsersController do
  describe "POST #create" do
    let(:attributes) { attributes_for(:user).merge(email).merge(password) }
    let(:email)      { {} }
    let(:password)   { { password: "12" } }

    before { post :create, user: attributes }

    context "with valid attributes" do
      it "should return a status 200" do
        expect(envelope_status).to eq 200
      end
    end

    context "with invalid attributes" do
      let(:email) { { email: "" } }

      it "should return a status 422" do
        expect(envelope_status).to eq 422
      end
    end
  end

  describe "PUT/PATCH #update" do
    let(:attributes) { { email: email, first_name: "new_first" } }
    let(:email)      { "new_email@gmail.com" }
    let(:key)        { create :key }
    let(:user)       { key.credential.user }

    before do
      api_token key.token
      patch :update, id: user.id, user: attributes
    end

    context "with valid attributes" do
      it "should return a status 200" do
        expect(envelope_status).to eq 200
      end
    end

    context "with invalid attributes" do
      let(:email) { "" }

      it "should return a status 422" do
        expect(envelope_status).to eq 422
      end
    end
  end
end
