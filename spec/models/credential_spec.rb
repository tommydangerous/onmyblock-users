require "rails_helper"

RSpec.describe Credential do
  subject { build :credential }

  it { should have_fields(:confirmed_at).of_type DateTime }
  it { should have_fields(:digest, :identification, :provider).of_type String }
  it { should have_fields(:user_id) }

  it { should validate_presence_of :digest }
  it { should validate_presence_of :identification }
  it { should ensure_inclusion_of(:provider).to_allow(
    Credential::PROVIDERS.values) }
    it { should have_many(:keys) }
  it { should validate_presence_of :user_id }
  it { should be_valid }

  it_should_behave_like :crud

  it { should have_many(:keys).with_dependent :destroy }

  it { should belong_to :user }

  it { should have_index_for(identification: 1).with_options unique: true }
end
