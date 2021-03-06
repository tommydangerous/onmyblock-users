require "rails_helper"

RSpec.describe MailEnvelopeSerializer do
  let(:deliver_action) { "deliver_action" }
  let(:envelope)       { MailEnvelope.new options }
  let(:from)           { "from@gmail.com" }
  let(:hash)           { described_class.new(envelope).serializable_hash }
  let(:name)           { "name" }
  let(:options) do
    {
      deliver_action: deliver_action,
      from:           from,
      name:           name,
      to:             to
    }
  end
  let(:payload) { { from: from, to: to } }
  let(:to)      { "to@gmail.com" }

  it "should have deliver_action" do
    expect(hash[:mailer][:deliver_action]).to eq deliver_action
  end

  it "should have name" do
    expect(hash[:mailer][:name]).to eq name
  end

  it "should have payload" do
    expect(hash[:mailer]).to have_key :payload
  end

  it "should have from and to in the payload" do
    json = hash[:mailer][:payload].to_json
    expect(json).to match from
    expect(json).to match to
  end

  it "should not have deliver_action and name in the payload" do
    json = hash[:mailer][:payload].to_json
    expect(json).not_to match deliver_action
    expect(json).not_to match name
  end
end
