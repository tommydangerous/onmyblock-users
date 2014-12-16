require_relative "../../app/services/read_service"
require_relative "../../spec/support/collection_mock"

RSpec.describe ReadService do
  subject { described_class.new model, options }

  let(:email)   { "test@gmail.com" }
  let(:id)      { rand(100) }
  let(:model)   { CollectionMock }
  let(:options) { { id: id, email: email } }
  let(:valid_attributes) { { id: id, email: email } }

  describe "#process" do
    before { subject.process }

    context "when record not found" do
      let(:options) { { email: "" } }

      it "should return a status of 404" do
        expect(subject.status).to eq 404
      end
    end
  end

  describe "#record" do
    context "when the options contain correct query attributes" do
      it "should return an object from the database" do
        object = model.create valid_attributes
        expect(subject.record).to eq object
      end
    end

    context "when the options do not contain correct query attributes" do
      let(:options) { { email: "" } }

      it "should return nil" do
        expect(subject.record).to be_nil
      end
    end
  end
end
