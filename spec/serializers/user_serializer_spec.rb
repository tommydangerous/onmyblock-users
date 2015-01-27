require "rails_helper"

RSpec.describe UserSerializer do
  let(:user) { create :user }
  let(:hash) { described_class.new(user).serializable_hash }

  %i(email first_name last_name phone_number).each do |key|
    it "should have #{key}" do
      expect(hash[key]).to eq user.send(key)
    end
  end

  it "should have an id" do
    expect(hash[:id]).to eq user.id.to_s
  end
end
