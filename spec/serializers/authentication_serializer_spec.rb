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

  %i(token expires_at).each do |name|
    it "should have #{name}" do
      expect(hash[name]).to eq object.key.send(name.to_sym)
    end
  end

  %i(email first_name last_name).each do |name|
    it "should have #{name}" do
      expect(hash[name]).to eq object.key.user.send(name.to_sym)
    end
  end

  it "should have an id" do
    expect(hash[:id]).to eq object.key.user.id.to_s
  end
end
