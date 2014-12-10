require "rails_helper"

RSpec.describe UserService do
  let(:service) { UserService.new }

  describe ".create_user" do
    it "should return a hash with a response key" do
      hash = service.create_user {}
      expect(hash).to have_key :response
    end

    it "should return a hash with a status key" do
      hash = UserService.new.create_user({})
      expect(hash).to have_key :status
    end

    context "when successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        @hash = service.create_user @user_attributes
      end

      it "should return response user" do
        expect(@hash[:response]).to eq User.first
      end

      it "should return status 201" do
        expect(@hash[:status]).to eq 201
      end
    end

    context "when failed to create" do
      before(:each) do
        @user_attributes = { first_name: "test", last_name: "test" }
        @hash = service.create_user @user_attributes
      end

      it "should return response with errors" do
        hash = JSON.parse @hash[:response]
        expect(hash).to have_key "errors"
      end

      it "should return status 422" do
        expect(@hash[:status]).to eq 422
      end
    end
  end
end
