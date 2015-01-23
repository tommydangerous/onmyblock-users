require "rails_helper"

RSpec.describe CredentialResetMailer do
  describe "#create" do
    let(:from)    { "from@gmail.com" }
    let(:mail)    { described_class.create options }
    let(:subject) { "subject" }
    let(:text)    { "text" }
    let(:to)      { "to@gmail.com" }

    let(:options) do
      {
        from:    from,
        subject: subject,
        text:    text,
        to:      to
      }
    end

    it "should contain text in the body" do
      expect(mail.body.encoded).to match text
    end
  end
end
