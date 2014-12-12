require_relative "../../app/services/create_service"

COLLECTIONS = {}

RSpec.describe DeleteService do
  subject { described_class.new model, options }

  let :model do
    Class.new do
      pattr_initialize :options

      def self.count
        COLLECTIONS.size
      end

      def self.find(pk)
        COLLECTIONS[pk]
      end

      def destroy
        COLLECTIONS.delete id
      end

      def id
        @id ||= Time.zone.now.to_s
      end

      def initialize
        COLLECTIONS[id] = self
      end
    end
  end

  let(:options) { { id: record.id } }
  let(:record) { model.new }

  describe "#process" do
    before { subject.process }

    context "with an ID of an existing record" do
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

      before { record }

      it "should not destroy any records" do
        expect(model.count).to eq 1
      end

      it "should return a response" do
        expect(subject.response).not_to be_nil
      end

      it "should return a status of 422" do
        expect(subject.status).to eq 422
      end
    end
  end
end
