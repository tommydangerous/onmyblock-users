require "rails_helper"

RSpec.describe Mailer do
  let(:deliver_action) { "confirmation" }
  let(:name)   { "credential" }
  let(:payload) do
    {
      from: "from@gmail.com",
      to:   "to@gmail.com"
    }
  end

  subject do
    described_class.new(
      deliver_action: deliver_action, name: name, payload: payload
    )
  end

  it { should respond_to :deliver_action }
  it { should respond_to :name }
  it { should respond_to :payload }

  it { should validate_presence_of :deliver_action }
  it { should validate_presence_of :name }
  it { should validate_presence_of :payload }

  it { should be_valid }

  describe "#save" do
    context "with valid attributes" do
      it "should deliver an email" do
        expect { subject.save }.to change {
          subject.send(:mailer).deliveries.count
        }.by 1
      end

      it "should return true" do
        expect(subject.save).to be true
      end
    end

    context "with invalid attributes" do
      let(:payload) { {} }

      it "should have errors" do
        subject.save
        expect(subject.errors.messages).to have_key :send_failed
      end

      it "should return false" do
        expect(subject.save).to be false
      end
    end
  end
end
