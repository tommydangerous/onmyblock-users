require "rails_helper"

RSpec.describe Key do
  subject { build :key }

  it { should have_fields(:credential_id) }
  it { should have_fields(:expires_at).of_type DateTime }
  it { should have_fields(:token, :type).of_type String }

  it { should validate_inclusion_of(:type).to_allow(Key::TYPES.values) }
  it { should validate_presence_of :credential_id }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }
  it { should validate_presence_of :type }
  it { should validate_uniqueness_of :token }
  it { should be_valid }

  it_should_behave_like :crud

  it { should belong_to :credential }

  it { should have_index_for(credential_id: 1) }
  it { should have_index_for(token: 1) }

  describe ".generate_access_token" do
    it "should return a unique string" do
      token1 = Key.generate_access_token
      token2 = Key.generate_access_token
      expect(token1).not_to be_nil
      expect(token2).not_to be_nil
      expect(token1).not_to eq token2
    end
  end

  describe "#assign_token" do
    it "should assign the new token" do
      token = Key.generate_access_token
      subject.assign_token token
      expect(subject.token).to eq token
    end
  end
end
