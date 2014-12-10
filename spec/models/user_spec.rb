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

  describe "#as_json" do
    it "should have an email key and value" do
      expect(subject.as_json[:email]).to eq subject.email
    end
    it "should have an first_name key and value" do
      expect(subject.as_json[:first_name]).to eq subject.first_name
    end
    it "should have an last_name key and value" do
      expect(subject.as_json[:last_name]).to eq subject.last_name
    end
  end
end
