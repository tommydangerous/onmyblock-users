require "rails_helper"

RSpec.describe Mailer do
  class TestMailer < BaseMailer
    def test_action(opts)
      capture_options opts
      mail from: from, to: to do |format|
        format.text do
          render text: "test"
        end
      end
    end
  end

  let(:deliver_action) { "test_action" }
  let(:from)           { "from@gmail.com" }
  let(:name)           { "test" }
  let(:payload) do
    {
      from: from,
      to:   to
    }
  end
  let(:to) { "to@gmail.com" }

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
          ActionMailer::Base.deliveries.count
        }.by 1
      end

      it "should deliver from the correct from" do
        subject.save
        expect(ActionMailer::Base.deliveries.first.from).to eq [from]
      end

      it "should deliver to the correct to" do
        subject.save
        expect(ActionMailer::Base.deliveries.first.to).to eq [to]
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
