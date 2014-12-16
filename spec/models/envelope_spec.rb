require_relative "../../app/models/envelope"

RSpec.describe Envelope do
  let(:envelope) do
    Envelope.new errors: errors, metadata: metadata, resource: resource
  end
  let(:errors)   { { missing_value: "a value is missing" } }
  let(:metadata) { { status: 200 } }
  let(:resource) { { first_name: "first", last_name: "last" } }

  describe "#as_json" do
    it "should have errors" do
      expect(envelope.as_json[:errors]).to eq errors
    end

    it "should have metadata" do
      expect(envelope.as_json[:metadata]).to eq metadata
    end

    it "should have resource" do
      expect(envelope.as_json[:resource]).to eq resource
    end
  end
end
