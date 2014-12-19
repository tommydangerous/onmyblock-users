require "rails_helper"

RSpec.describe Credential do
  subject { build :credential }

  it { should have_fields(:confirmed_at).of_type DateTime }
  it { should have_fields(:identification, :provider).of_type String }
  it { should have_fields(:password_digest).with_alias(:digest).of_type String }
  it { should have_fields(:user_id) }

  it { should validate_presence_of :identification }
  it do
    should validate_inclusion_of(:provider)
      .to_allow(Credential::PROVIDERS.values)
  end

  it { should have_many(:keys) }
  it { should validate_presence_of :user_id }
  it { should be_valid }

  it_should_behave_like :crud

  it { should have_many(:keys).with_dependent :destroy }

  it { should belong_to :user }

  it { should have_index_for(identification: 1).with_options unique: true }
  it { should have_index_for(user_id: 1) }

  let(:credential) { create :credential, password: password }
  let(:password) { "password" }

  describe "#authenticate" do
    it "should authenticate and return the object" do
      expect(credential.authenticate password).to eq credential
    end

    it "should not authenticate and return false" do
      expect(credential.authenticate "").to eq false
    end
  end

  describe "#validate_password_create" do
    it "should be valid with password length 2 or more" do
      subject.password = "12"
      expect(subject.valid?).to be true
    end

    it "should not be valid with password length less than 2" do
      subject.password = "1"
      expect(subject.valid?).to be false
    end
  end

  describe "#validate_password_update" do
    it "should be valid with no password changes" do
      credential.password = nil
      expect(credential.save).to be true
    end

    it "should not be valid with password length less than 2" do
      credential.password = "1"
      expect(credential.save).to be false
    end
  end

  describe "#create_access_key" do
    let(:key) { credential.create_access_key }

    it "should create a key" do
      expect(credential.keys).to include key
    end

    it "should create a key with an expires_at" do
      expect(key.expires_at).not_to be_nil
    end

    it "should create a key with a token" do
      expect(key.token).not_to be_nil
    end
  end

  # describe "#send_confirmation" do
  #   it "should send a confirmation email" do
  #     expect { credential.send_confirmation }.to change {
  #       CredentialMailer.deliveries.count
  #     }
  #   end
  # end
end
