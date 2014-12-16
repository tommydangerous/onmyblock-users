require_relative "../../app/models/envelope"

RSpec.describe Envelope do
  subject { described_class.new }

  it { should respond_to :errors }
  it { should respond_to :metadata }
  it { should respond_to :resource }
end
