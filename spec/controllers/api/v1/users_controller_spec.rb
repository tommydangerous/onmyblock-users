require "rails_helper"

RSpec.describe Api::V1::UsersController do
  before(:each) { request.headers["Accept"] == "application/vnd.users.v1" }

  describe "GET #show" do
    before(:each) do
      @user = create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about the user in JSON" do
      resp = json_response
      expect(resp[:email]).to eq @user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the JSON representation for the user record just created" do
        resp = json_response
        expect(resp[:email]).to eq @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when failed to create" do
      before(:each) do
        @user_attributes = { first_name: "test", last_name: "test" }
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders JSON with errors" do
        resp = json_response
        puts resp
        expect(resp).to have_key(:errors)
      end

      it "renders JSON with errors on why the user could not be created" do
        resp = json_response
        expect(resp[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    context "when successfully updated" do
      let(:new_email) { "new@gmail.com" }
      before(:each) do
        @user = create :user
        patch :update, { id: @user.id, user: { email: new_email } }, 
          format: :json
      end

      it "renders JSON for the updated user" do
        resp = json_response
        expect(resp[:email]).to eq new_email
      end

      it { should respond_with 200 }
    end

    context "when failed to update" do
      before(:each) do
        @user = create :user
        patch :update, { id: @user.id, user: { email: "bademail" } }, 
          format: :json
      end

      it "renders JSON with errors" do
        resp = json_response
        expect(resp).to have_key :errors
      end

      it "renders JSON with errors on why the user could not be updated" do
        resp = json_response
        expect(resp[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = create :user
      delete :destroy, { id: @user.id }, format: :json
    end

    it "should destroy the user record" do
      expect(User.count).to eq 0
    end

    it { should respond_with 204 }
  end
end
