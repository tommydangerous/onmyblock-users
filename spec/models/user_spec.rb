require "rails_helper"

RSpec.describe User do
  subject { build :user }

  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

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
end
