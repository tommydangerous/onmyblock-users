require "rails_helper"

RSpec.describe Credential do
  subject { build :credential }

  # identification
  # digest (password_digest)
  # provider: facebook, onmyblock
  # confirmed_at

  it { should validate_presence_of :user_id }
  # it { should validate_presence_of : }
end
