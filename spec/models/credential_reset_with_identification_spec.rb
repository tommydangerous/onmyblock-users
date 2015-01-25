require "rails_helper"

RSpec.describe CredentialResetWithIdentification do
  let(:credential) { create :credential }
  let(:subject) do
    described_class.new identification: credential.identification
  end

  context "when credential exists" do
    it { should be_valid }
  end

  context "when credential does not exist" do
    let(:credential) { double "credential", identification: "" }

    it { should_not be_valid }
  end

  describe "#errors" do
    context "when valid" do
      it "should not have errors" do
        expect(subject.errors).not_to have_key :credential
      end
    end

    context "when invalid" do
      let(:credential) { double "credential", identification: "" }

      it "should have errors" do
        expect(subject.errors).to have_key :credential
      end
    end
  end
end
