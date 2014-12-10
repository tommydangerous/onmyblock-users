require "rails_helper"

RSpec.describe UserSerializer do
  let(:user) { create :user }
  let(:hash) { UserSerializer.new(user).serializable_hash }

  it "should have email" do
    expect(hash[:email]).to eq user.email
  end

  it "should have first_name" do
    expect(hash[:first_name]).to eq user.first_name
  end

  it "should have last_name" do
    expect(hash[:last_name]).to eq user.last_name
  end
end
