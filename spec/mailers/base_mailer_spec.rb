require "rails_helper"

RSpec.describe BaseMailer do
  let(:from)         { "from" }
  let(:mail_subject) { "subject" }
  let(:options) do
    {
      from:    from,
      subject: mail_subject,
      to:      to
    }
  end
  let(:subject) { described_class.send :new }
  let(:to)      { "to" }

  describe "#capture_options" do
    before { subject.send :capture_options, options }

    context "when options is a hash" do
      it "should have the correct from" do
        expect(subject.from).to eq from
      end

      it "should have the correct subject" do
        expect(subject.subject).to eq mail_subject
      end

      it "should have the correct to" do
        expect(subject.to).to eq to
      end
    end

    context "when options is a string" do
      let(:options) do
        {
          from:    from,
          subject: mail_subject,
          to:      to
        }.to_json
      end

      it "should have the correct from" do
        expect(subject.from).to eq from
      end

      it "should have the correct subject" do
        expect(subject.subject).to eq mail_subject
      end

      it "should have the correct to" do
        expect(subject.to).to eq to
      end
    end
  end
end
