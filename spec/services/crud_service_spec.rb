require_relative "../../app/services/crud_service"

RSpec.describe CrudService do
  subject { described_class.new model, options }

  let(:model)   { double "model" }
  let(:options) { double "options" }

  it { should respond_to :response }
  it { should respond_to :status }
end
