require "rails_helper"

RSpec.describe UserKeySerializer do
  let(:credential) { create :credential, user: user }
  let(:key)        { create :key, credential: credential }
  let(:hash)       { described_class.new(object).serializable_hash }
  let(:object)     { UserKey.new key: key, user: user }
  let(:user)       { create :user }

  it "should have user email" do
    expect(hash).to have_key :email
  end

  it "should have key token" do
    expect(hash).to have_key :token
  end
end
