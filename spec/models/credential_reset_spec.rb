require "rails_helper"

RSpec.describe CredentialReset do
  subject { build :credential_reset }

  it { should have_fields(:credential_id) }
  it { should have_fields(:expires_at).of_type DateTime }
  it { should have_fields(:token).of_type String }

  it { should validate_presence_of :credential_id }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }

  it { should belong_to :credential }

  it { should have_index_for credential_id: 1 }
end
