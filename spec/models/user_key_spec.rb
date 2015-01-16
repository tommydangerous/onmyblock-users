require "rails_helper"

RSpec.describe UserKey do
  let(:subject) { described_class.new }

  it { should respond_to :key }
  it { should respond_to :user }
end
