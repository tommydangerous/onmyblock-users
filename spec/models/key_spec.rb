require "rails_helper"

RSpec.describe Key do
  subject { build :key }

  it { should have_fields(:credential_id) }
  it { should have_fields(:expires_at).of_type DateTime }
  it { should have_fields(:token, :key_type).of_type String }

  it { should validate_inclusion_of(:key_type).to_allow(Key::KEY_TYPES.values) }
  it { should validate_presence_of :credential_id }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }
  it { should validate_presence_of :key_type }
  it { should validate_uniqueness_of :token }
  it { should be_valid }

  it_should_behave_like :crud

  it { should belong_to :credential }

  it { should have_index_for(credential_id: 1) }
  it { should have_index_for(token: 1) }

  describe ".generate_access_token" do
    it "should return a unique string" do
      token1 = described_class.generate_access_token
      token2 = described_class.generate_access_token
      expect(token1).not_to be_nil
      expect(token2).not_to be_nil
      expect(token1).not_to eq token2
    end
  end

  describe "#assign_expires_at" do
    it "should set the expires_at to a future date" do
      subject.expires_at = nil
      subject.assign_expires_at
      expect(subject.expires_at).to be > Time.zone.now
    end
  end

  describe "#assign_token" do
    it "should assign the new token" do
      token = described_class.generate_access_token
      subject.assign_token token
      expect(subject.token).to eq token
    end
  end

  describe "#configure_defaults" do
    it "should receive :assign_expires_at" do
      expect(subject).to receive :assign_expires_at
      subject.configure_defaults
    end

    it "should receive :assign_token" do
      expect(subject).to receive :assign_token
      subject.configure_defaults
    end
  end

  describe "#expired?" do
    context "when expires_at is in the future" do
      before { subject.expires_at = Time.now + 1.day }

      it "should return false" do
        expect(subject.expired?).to be false
      end
    end

    context "when expires_at is in the past" do
      before { subject.expires_at = Time.now - 1.day }

      it "should return true" do
        expect(subject.expired?).to be true
      end
    end
  end

  describe "#user" do
    it "should return the credential's user" do
      expect(subject.user).to eq subject.credential.user
    end
  end
end
