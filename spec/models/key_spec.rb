require "rails_helper"

RSpec.describe Key do
  subject { build :key }

  it { should validate_presence_of :expires_at }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }

  it { should respond_to :expires_at }
  it { should respond_to :token }

  it { should be_valid }

  it_should_behave_like :crud

  # it { should belong_to :credential }
end
