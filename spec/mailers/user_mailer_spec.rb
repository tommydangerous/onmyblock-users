require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do
  describe "confirmation" do
    let(:user) do
      double "user", email:      "user@gmail.com", 
                     first_name: "first", 
                     last_name:  "last"
    end
    let(:mail) { UserMailer.confirmation user }

    it "should render the subject" do
      expect(mail.subject).to eq "Confirmation"
    end

    it "should render the receiver email" do
      expect(mail.to).to eq [user.email]
    end

    it "should render the sender email" do
      expect(mail.from).to eq ["info@onmyblock.com"]
    end

    it "should assign @first_name" do
      expect(mail.body.encoded).to match user.first_name
    end
  end
end
