require "rails_helper"

RSpec.describe UsersController do
  let(:controller) { UsersController.new }

  describe "#create" do
    let(:email) { "email@gmail.com" }
    let(:first_name) { "first" }
    let(:last_name) { "last" }

    context "valid" do
      before do
        post :create, user: {
          email:      email,
          first_name: first_name,
          last_name:  last_name
        }, format: :json
      end
      it "should respond with status 201" do
        expect(response.status).to eq 201
      end
      it "should create a user" do
        expect(User.count).to eq 1
      end
      it "should return a user JSON object with the correct values" do
        hash = JSON.parse response.body
        expect(hash["email"]).to eq email
        expect(hash["first_name"]).to eq first_name
        expect(hash["last_name"]).to eq last_name
      end
    end
  end
end
