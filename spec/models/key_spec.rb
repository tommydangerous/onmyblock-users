require "rails_helper"

RSpec.describe Key do
  subject { build :key }

  it { should ensure_inclusion_of(:type).in_array(Key::TYPES.values) }
  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }
  it { should be_valid }

  it { should respond_to :expires_at }
  it { should respond_to :token }
  it { should respond_to :type }

  it_should_behave_like :crud
end
