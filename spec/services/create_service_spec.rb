require "rails_helper"

RSpec.describe CreateService do
  let(:invalid_attributes) { { first_name: "test", last_name: "test" } }
  let(:valid_attributes) { FactoryGirl.attributes_for :user }

  describe "#process" do
    context "with any attributes" do
      before(:each) do
        @service = CreateService.new User, {}
        @service.process
      end

      it "should have a response" do
        expect(@service.response).not_to be_nil
      end

      it "should have a status" do
        expect(@service.status).not_to be_nil
      end
    end

    context "with valid attributes" do
      before(:each) do
        @service = CreateService.new User, valid_attributes
        @service.process
      end

      it "should have a response equal to the record" do
        expect(@service.response).to eq @service.record
      end

      it "should have a status of 201" do
        expect(@service.status).to eq 201
      end
    end

    context "with invalid attributes" do
      before(:each) do
        @service = CreateService.new User, invalid_attributes
        @service.process
      end

      it "should have a response with errors" do
        expect(@service.response).to have_key :email
      end

      it "should have a status of 422" do
        expect(@service.status).to eq 422
      end
    end
  end

  describe "#record" do
    let(:service) { CreateService.new(User, {}) }

    it "should return an object" do
      expect(service.record).not_to be_nil
    end
  end
end
