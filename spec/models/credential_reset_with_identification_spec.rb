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
end
