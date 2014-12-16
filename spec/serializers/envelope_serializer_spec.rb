require_relative "../../app/models/envelope"
require_relative "../../app/serializers/envelope_serializer"

RSpec.describe EnvelopeSerializer do
  let(:envelope) do
    Envelope.new errors: errors, metadata: metadata, resource: resource
  end
  let(:errors)   { { missing_value: "a value is missing" } }
  let(:hash)     { described_class.new(envelope).serializable_hash }
  let(:metadata) { { status: 200 } }
  let(:resource) { { first_name: "first", last_name: "last" } }

  it "should have errors" do
    expect(hash[:errors]).to eq errors
  end

  it "should have metadata" do
    expect(hash[:metadata]).to eq metadata
  end

  it "should have resource" do
    expect(hash[:resource]).to eq resource
  end
end
