require "rails_helper"

RSpec.describe MailEnvelopeSerializer do
  let(:envelope) { MailEnvelope.new options }
  let(:hash)     { described_class.new(envelope).serializable_hash }
  let(:options)  { {} }
end
