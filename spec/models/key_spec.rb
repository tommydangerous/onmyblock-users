require "rails_helper"

RSpec.describe Key do
  subject { build :key }

  it { should have_fields(:credential_id) }
  it { should have_fields(:expires_at).of_type DateTime }
  it { should have_fields(:token, :type).of_type String }

  it { should validate_inclusion_of(:type).to_allow(Key::TYPES.values) }
  it { should validate_presence_of :credential_id }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }
  it { should be_valid }

  it_should_behave_like :crud

  it { should belong_to :credential }

  it { should have_index_for(credential_id: 1) }
end
