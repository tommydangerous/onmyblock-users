require "rails_helper"

RSpec.describe CredentialUpdateFromResetSerializer do
  let(:hash)   { described_class.new(record).serializable_hash }
  let(:record) { CredentialUpdateFromReset.new }

  it "should have no keys" do
    expect(hash).to be_empty
  end
end
