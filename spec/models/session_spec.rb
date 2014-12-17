require "rails_helper"

RSpec.describe Session do
  let(:key)   { create :key }
  let(:token) { key.token }

  subject { described_class.new token }

  describe "#key" do
    context "when key exists" do
      it "should return user" do
        expect(subject.key).to eq key
      end
    end

    context "when key doesn't exist" do
      let(:token) { "" }

      it "should return nil" do
        expect(subject.key).to be_nil
      end
    end
  end

  describe "#expired?" do
    context "when key not expired" do
      it "should return false" do
        expect(subject.expired?).to be false
      end
    end

    context "when key expired" do
      it "should return true" do
        key.update expires_at: Time.now - 1.day
        expect(subject.expired?).to be true
      end
    end
  end

  describe "#signed_in?" do
    context "when key exists" do
      it "should return false" do
        expect(subject.signed_in?).to be true
      end
    end

    context "when key doesn't exist" do
      let(:token) { "" }

      it "should return false" do
        expect(subject.signed_in?).to be false
      end
    end
  end

  describe "#user" do
    context "when key exists" do
      it "should return user" do
        expect(subject.user).to eq key.credential.user
      end
    end

    context "when key doesn't exist" do
      let(:token) { "" }

      it "should return nil" do
        expect(subject.user).to be_nil
      end
    end
  end
end
