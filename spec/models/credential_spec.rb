require "rails_helper"

RSpec.describe Credential do
  subject { build :credential }

  it { should have_fields(:confirmed_at).of_type DateTime }
  it { should have_fields(:identification, :provider).of_type String }
  it { should have_fields(:password_digest).with_alias(:digest).of_type String }
  it { should have_fields(:user_id) }

  it { should validate_presence_of :password_digest }
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

  describe "#authenticate" do
    let(:credential) { create :credential, password: password }
    let(:password) { "password" }

    it "should authenticate and return the object" do
      expect(credential.authenticate password).to eq credential
    end

    it "should not authenticate and return false" do
      expect(credential.authenticate "").to eq false
    end
  end

  describe "#validate_password" do
    it "should be valid with password length 2 or more" do
      subject.password = "12"
      expect(subject.valid?).to be true
    end

    it "should not be valid with password length less than 2" do
      subject.password = "1"
      expect(subject.valid?).to be false
    end
  end
end
