require "rails_helper"

RSpec.describe CredentialMailer do
  describe "#confirmation" do
    let(:credential) { create :credential }
    let(:key)        { create :key, credential: credential }
    let(:mail)       { described_class.confirmation credential, key }

    it "should render the subject" do
      expect(mail.subject).to eq "Confirmation"
    end

    it "should render the receiver email" do
      expect(mail.to).to eq [credential.user.email]
    end

    it "should render the sender email" do
      expect(mail.from).to eq ["info@onmyblock.com"]
    end

    it "should contain a url with the id and token in the body" do
      expect(mail.body.encoded).to match credential.id
      expect(mail.body.encoded).to match key.token
    end
  end
end
