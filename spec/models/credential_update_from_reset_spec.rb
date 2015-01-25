require "rails_helper"

RSpec.describe CredentialUpdateFromReset do
  let(:credential_reset) { create :credential_reset }
  let(:password)         { "password" }
  let(:token)            { credential_reset.token }
  let(:subject) { described_class.new password: password, token: token }

  describe "#save" do
    context "with valid token" do
      context "when not expired" do
        context "with valid password" do
          it "should return true" do
            expect(subject.save).to be true
          end

          it "should make credential_reset expired" do
            subject.save
            credential_reset.reload
            expect(credential_reset.expired?).to be true
          end
        end

        context "with invalid password" do
          let(:password) { "p" }

          it "should return false" do
            expect(subject.save).to be false
          end

          it "should have errors" do
            subject.save
            expect(subject.errors).to have_key :password
          end
        end
      end

      context "when expired" do
        let(:credential_reset) do
          create :credential_reset, expires_at: Time.now - 1.day
        end

        it "should return false" do
          expect(subject.save).to be false
        end

        it "should have errors" do
          subject.save
          expect(subject.errors).to have_key :expired
        end
      end
    end

    context "with invalid token" do
      let(:token) { "" }

      it "should return false" do
        expect(subject.save).to be false
      end

      it "should have errors" do
        subject.save
        expect(subject.errors).to have_key :invalid_token
      end
    end
  end
end
