require "rails_helper"

RSpec.describe AuthenticationSerializer do
  let(:credential) { create :credential, password: password }
  let(:object) do
    Authentication.new(
      identification: credential.identification, password: password
    )
  end
  let(:password) { "password" }
  let(:hash)     { described_class.new(object).serializable_hash }

  before { object.save }

  it "should have token" do
    expect(hash[:token]).to eq object.key.token
  end

  it "should have expires_at" do
    expect(hash[:expires_at]).to eq object.key.expires_at
  end
end
