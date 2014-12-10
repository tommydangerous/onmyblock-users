require "rails_helper"

RSpec.describe CrudService do
  let(:service) { CrudService.new nil, {} }
  subject { service }

  it { should respond_to :response }
  it { should respond_to :status }
end
