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
    end

    context "with invalid object" do
      let(:object) { CredentialReset.new }

      it "should not receive :deliver_email" do
        expect(subject).not_to receive :deliver_email
        subject.save
      end
    end
  end
end
