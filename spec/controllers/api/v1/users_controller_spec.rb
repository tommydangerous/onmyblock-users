require "rails_helper"

RSpec.describe Api::V1::UsersController do
  describe "POST #create" do
    before(:each) { post :create, user: attributes }

    let(:attributes) { attributes_for :user }

    xit "should return a status" do
      expect(response.status).not_to be_nil
    end
  end

  describe "PUT/PATCH #update" do
    before { patch :update, id: user.id, user: attributes }

    let(:user) { create :user }
    let(:attributes) { { first_name: "new_first", last_name: "new_last" } }

    # Test status
  end
end
