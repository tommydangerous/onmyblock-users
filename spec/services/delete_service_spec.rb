require_relative "../../app/services/delete_service"
require_relative "../../spec/support/collection_mock"

RSpec.describe DeleteService do
  subject { described_class.new model, options }

  let(:email)   { "test@gmail.com" }
  let(:id)      { rand(100) }
  let(:model)   { CollectionMock }
  let(:options) { { id: id } }
  let(:valid_attributes) { { id: id, email: email } }

  describe "#process" do
    context "with an ID of an existing record" do
      before do
        model.create valid_attributes
        subject.process
      end

      after { model.destroy_all }

      it "should destroy the record" do
        expect(model.count).to eq 0
      end

      it "should return a response" do
        expect(subject.response).not_to be_nil
      end

      it "should return a status of 204" do
        expect(subject.status).to eq 204
      end
    end

    context "with an ID of a non existent record" do
      let(:options) { { id: "0" } }

      before do
        model.create valid_attributes
        subject.process
      end

      after { model.destroy_all }

      it "should not destroy any records" do
        expect(model.count).to eq 1
      end

      it "should return a status of 422" do
        expect(subject.status).to eq 422
      end
    end
  end
end
