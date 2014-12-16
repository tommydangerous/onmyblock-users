require_relative "../../app/services/update_service"
require_relative "../../spec/support/collection_mock"

RSpec.describe UpdateService do
  subject { described_class.new model, record_id, options }

  let(:email)     { "test@gmail.com" }
  let(:id)        { rand(100) }
  let(:model)     { CollectionMock }
  let(:new_email) { "new_test@gmail.com" }
  let(:options)   { { email: new_email } }
  let(:record)    { model.create valid_attributes }
  let(:record_id) { record.id }
  let(:valid_attributes) { { id: id, email: email } }

  describe "#process" do
    before do
      model.destroy_all
      record
      subject.process
    end

    context "when record found" do
      it "should update record" do
        expect(record.email).to eq new_email
      end
    end

    context "when record not found" do
      let(:options) { { email: new_email } }
      let(:record_id) { "" }

      it "should not update record" do
        expect(record.email).to eq email
      end
    end
  end
end
