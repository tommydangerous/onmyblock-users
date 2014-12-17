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
                   password:       login_password
    end

    context "with valid identification and password" do
      it "should return status 200" do
        expect(envelope_status).to eq 200
      end
    end

    context "with invalid password" do
      let(:login_password) { "" }

      it "should return status 401" do
        expect(envelope_status).to eq 401
      end
    end
  end

  # describe "DELETE #logout" do
  #   let(:key) { create :key }

  #   before { delete :logout, token: key.token }

  #   it "should return a response" do
  #     expect(response.body).not_to be_nil
  #   end

  #   xit "should return a status" do
  #     expect(response.status).not_to be_nil
  #   end
  # end
end
