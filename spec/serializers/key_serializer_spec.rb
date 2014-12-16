require "rails_helper"

RSpec.describe KeySerializer do
  let(:key) { create :key }
  let(:hash) { described_class.new(key).serializable_hash }

  it "should have expires_at" do
    expect(hash[:expires_at]).to eq key.expires_at
  end

  it "should have token" do
    expect(hash[:token]).to eq key.token
  end
end
