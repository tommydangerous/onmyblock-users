require "rails_helper"

RSpec.describe CredentialResetWithIdentificationSerializer do
  let(:credential) { create :credential }
  let(:hash)       { described_class.new(record).serializable_hash }
  let(:record) do
    CredentialResetWithIdentification.new(
      identification: credential.identification
    )
  end

  it "should have an expires_at" do
    expect(hash[:expires_at]).to eq record.credential_reset.expires_at
  end

  it "should have an id" do
    expect(hash[:id]).to eq record.credential_reset.id.to_s
  end
end
