require "rails_helper"

RSpec.describe User do
  # role
  # status

  subject { build :user }

  it { should respond_to :email }
  it { should respond_to :first_name }
  it { should respond_to :last_name }

  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it { should be_valid }

  it_should_behave_like :crud

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
