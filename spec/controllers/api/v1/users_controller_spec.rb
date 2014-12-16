require "rails_helper"

RSpec.describe Api::V1::UsersController do
  describe "POST #create" do
    before(:each) do
      @user_attributes = FactoryGirl.attributes_for(:user)
      post :create, { user: @user_attributes }
    end

    xit "should return a status" do
      expect(response.status).not_to be_nil
    end
  end

  describe "PUT/PATCH #update" do
    let(:user) { create :user }

    before do
      @attributes = { first_name: "new_first", last_name: "new_last" }
      patch :update, { id: user.id, user: @attributes }
    end

    xit "should return a status" do
      expect(response.status).not_to be_nil
    end
  end
end
