require "rails_helper"

RSpec.describe MailEnvelope do
  let(:options) { {} }

  subject { described_class.new options }

  it { should respond_to :bcc }
  it { should respond_to :bccname }
  it { should respond_to :cc }
  it { should respond_to :ccname }
  it { should respond_to :deliver_action }
  it { should respond_to :files }
  it { should respond_to :from }
  it { should respond_to :fromname }
  it { should respond_to :html }
  it { should respond_to :name }
  it { should respond_to :reply_to }
  it { should respond_to :subject }
  it { should respond_to :text }
  it { should respond_to :to }
  it { should respond_to :toname }

  describe "#initialize" do
    let(:deliver_action) { "create" }
    let(:options)        { { deliver_action: deliver_action } }

    it "should set @deliver_action" do
      expect(subject.deliver_action).to eq deliver_action
    end
  end
end
