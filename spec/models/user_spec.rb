require "rails_helper"

RSpec.describe User do
  let(:user) { create :user }

  subject { build :user }

  it do
    should have_fields(:email, :first_name, :last_name, :status, :phone_number)
      .of_type(String)
  end
  it { should have_fields(:roles).of_type Array }

  it do
    should validate_format_of(:email).to_allow("test@gmail.com")
      .not_to_allow("test")
  end
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_uniqueness_of :email }

  it { should be_valid }

  it_should_behave_like :crud

  it { should have_many(:credentials).with_dependent :destroy }

  it { should accept_nested_attributes_for :credentials }

  it { should have_index_for(email: 1).with_options unique: true }

  describe "validations" do
    context "for email" do
      it "should save with a valid email format" do
        subject.email = "test@gmail.com"
        expect(subject.save).to eq true
      end

      it "should not save with an invalid email format" do
        subject.email = "test@gmail"
        expect(subject.save).to eq false
      end
    end
  end

  describe "#validate_roles" do
    it "should be valid with valid roles" do
      subject.roles = [User::ROLES.values.first]
      expect(subject.valid?).to be true
    end

    it "should not be valid with invalid roles" do
      subject.roles = ["invalid"]
      expect(subject.valid?).to be false
    end
  end

  describe "#validate_status" do
    it "should be valid with valid status" do
      subject.status = User::STATUSES.values.first
      expect(subject.valid?).to be true
    end

    it "should not be valid with invalid status" do
      subject.status = "invalid"
      expect(subject.valid?).to be false
    end
  end

  context "when updating email" do
    context "when user has a credential" do
      let(:credential) { create :credential, user: user }
      let(:email)      { "new_email@gmail.com" }

      before { credential }

      it "should update the credential's identification" do
        user.update email: email
        credential.reload
        expect(credential.identification).to eq email
      end
    end
  end

  context "when updating anything but email" do
    context "when user has a credential" do
      let(:credential) { create :credential, user: user }

      before { credential }

      it "should not update the credential's identification" do
        user.update first_name: "new_first"
        credential.reload
        expect(credential.identification).to eq user.email
      end
    end
  end
end
