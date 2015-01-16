require "rails_helper"

RSpec.describe UserSerializer do
  let(:user) { create :user }
  let(:hash) { described_class.new(user).serializable_hash }

  %i(email first_name id last_name).each do |key|
    it "should have #{key}" do
      expect(hash[key]).to eq user.send(key)
    end
  end
end
