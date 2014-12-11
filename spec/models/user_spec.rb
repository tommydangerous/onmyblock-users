require "rails_helper"

RSpec.describe User do
  # role
  # status

  subject { build :user }

  it { should have_fields(:email, :first_name, :last_name).of_type String }
  it { should have_fields(:role).of_type Array }

  it { should respond_to :email }
  it { should respond_to :first_name }
  it { should respond_to :last_name }

  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it { should be_valid }

  it_should_behave_like :crud

  it { should have_many(:credentials).with_dependent :destroy }

  it { should have_index_for(email: 1).with_options unique: true }

  describe "validations" do
    context "for email" do
      it "should save with a valid email format" do
        puts subject.email
        subject.email = "test@gmail.com"
        expect(subject.save).to eq true
      end

      it "should not save with an invalid email format" do
        subject.email = "test@gmail"
        expect(subject.save).to eq false
      end
    end
  end
end
