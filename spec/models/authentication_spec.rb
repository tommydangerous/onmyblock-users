require "rails_helper"

RSpec.describe Authentication do
  let(:authentication_identification) { identification }
  let(:authentication_password)       { password }
  let(:credential)     { create :credential, password: password }
  let(:identification) { credential.identification }
  let(:password)       { "password" }

  subject do
    described_class.new(
      identification: authentication_identification,
      password:       authentication_password
    )
  end

  it { should respond_to :identification }
  it { should respond_to :key }
  it { should respond_to :password }

  it { should be_valid }

  describe "#save" do
    context "with correct identification and password" do
      it "should return true" do
        expect(subject.save).to be true
      end

      it "should create a key" do
        expect { subject.save }.to change { credential.keys.size }.by 1
      end

      it "should have a key" do
        subject.save
        expect(credential.keys).to include subject.key
      end
    end

    context "with incorrect password" do
      let(:authentication_password) { "" }

      it "should return false" do
        expect(subject.save).to be false
      end

      it "should not create a key" do
        expect { subject.save }.to change { credential.keys.size }.by 0
      end

      it "should not have a key" do
        subject.save
        expect(subject.key).to be_nil
      end
    end

    context "with incorrect identification" do
      let(:authentication_identification) { "" }

      it "should return false" do
        expect(subject.save).to be false
      end
    end
  end
end
