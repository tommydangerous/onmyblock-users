require "rails_helper"

RSpec.describe CredentialResetWithMail do
  let(:object)  { build :credential_reset }
  let(:subject) { described_class.new object }

  describe "#save" do
    context "with valid object" do
      it "should receive :deliver_email" do
        expect(subject).to receive :deliver_email
        subject.save
      end

      it "should send mailer :save" do
        expect(subject.send :mailer).to receive :save
        subject.save
      end
    end

    context "with invalid object" do
      let(:object) { CredentialReset.new }

      it "should not receive :deliver_email" do
        expect(subject).not_to receive :deliver_email
        subject.save
      end
    end
  end

  describe "#payload" do
    let(:payload) { subject.send :payload }

    it "should have the correct text" do
      expect(payload[:text]).to match object.token
    end

    it "should have the correct to" do
      expect(payload[:to]).to match object.credential.identification
    end
  end
end
