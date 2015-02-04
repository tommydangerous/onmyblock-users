require "rails_helper"

RSpec.describe CredentialMailer do
  describe "#confirmation" do
    let(:from)    { "from@gmail.com" }
    let(:mail)    { described_class.confirmation options }
    let(:options) { { from: from, to: to } }
    let(:to)      { "test@gmail.com" }

    it "should render the subject" do
      expect(mail.subject).to eq "Confirmation"
    end

    it "should render the receiver email" do
      expect(mail.to).to eq [to]
    end

    it "should render the sender email" do
      expect(mail.from).to eq [from]
    end

    it "should contain from and to in the body" do
      expect(mail.body.encoded).to match from
      expect(mail.body.encoded).to match to
    end
  end
end
