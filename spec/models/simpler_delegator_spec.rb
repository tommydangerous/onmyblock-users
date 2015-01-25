require "rails_helper"

RSpec.describe SimplerDelegator do
  let(:subject) { described_class.new "test" }

  describe "#object" do
    it "should equal __getobj__" do
      expect(subject.object).to eq subject.__getobj__
    end
  end
end
