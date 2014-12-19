require "rails_helper"

RSpec.describe MailEnvelopeSerializer do
  let(:action)   { "action" }
  let(:envelope) { MailEnvelope.new options }
  let(:from)     { "from@gmail.com" }
  let(:hash)     { described_class.new(envelope).serializable_hash }
  let(:mailer)   { "mailer" }
  let(:options) do
    {
      action:  action,
      from:    from,
      mailer:  mailer,
      to:      to
    }
  end
  let(:payload) { { from: from, to: to } }
  let(:to)      { "to@gmail.com" }

  it "should have mailer_action" do
    expect(hash[:mailer_action]).to eq action
  end

  it "should have mailer_name" do
    expect(hash[:mailer_name]).to eq mailer
  end

  it "should have payload" do
    expect(hash).to have_key :payload
  end

  it "should have from and to in the payload" do
    json = hash[:payload].to_json
    expect(json).to match from
    expect(json).to match to
  end
end
