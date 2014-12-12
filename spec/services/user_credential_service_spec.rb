require "rails_helper"

RSpec.describe UserCredentialService do
  let(:build_credential) { service.build_credential }
  let(:build_user) { service.build_user }
  let(:service) { UserCredentialService.new service_options }
  let(:service_options) { 
    FactoryGirl.attributes_for(:user).merge({ password: "password" })
  }

  describe "#build_credential" do
    it "should return a built credential with the same attributes" do
      expect(build_credential.identification).to eq(
        service_options[:email])
      expect(build_credential.password).to eq service_options[:password]
    end
  end

  describe "#build_user" do
    it "should return a built user with the same attributes" do
      expect(build_user.email).to eq service_options[:email]
      expect(build_user.first_name).to eq service_options[:first_name]
      expect(build_user.last_name).to eq service_options[:last_name]
    end
  end

  describe "#errors_response" do
    let(:errors) { hash[:response].to_hash }
    let(:hash) { service.errors_response }

    context "when user is not valid" do
      let(:service_options) { {} }

      it "should return a hash with response with errors" do
        expect(errors).to have_key :email
      end

      it "should return a hash with key status of value 422" do
        expect(hash[:status]).to eq 422
      end
    end

    context "when credential is not valid" do
      let(:service_options) { FactoryGirl.attributes_for :user }

      it "should return a hash with response with errors" do
        expect(errors).to have_key :password_digest
      end

      it "should return a hash with key status of value 422" do
        expect(hash[:status]).to eq 422
      end
    end
  end

  describe "#process" do
    before { service.process }

    it "should have a response" do
      expect(service.response).not_to be_nil
    end

    it "should have a status" do
      expect(service.status).not_to be_nil
    end
  end

  describe "#process_credential" do
    before { @hash = service.process_credential }

    it "should save a credential to the database" do
      expect(Credential.count).to eq 1
    end

    it "should create a credential that belongs to the user" do
      expect(service.user.credentials).to include @hash[:response]
    end
  end

  describe "#process_credential_from_user" do
    it "should send :set_credential_to_user message to service" do
      expect(service).to receive :set_credential_to_user
      service.process_credential_from_user
    end

    it "should send :process_credential message to service" do
      expect(service).to receive :process_credential
      service.process_credential_from_user
    end
  end

  describe "#process_key_from_credential" do
    before { @hash = service.process_key_from_credential }

    it "should save a key to the database" do
      expect(Key.count).to eq 1
    end

    it "should create a key that belongs to the credential" do
      expect(service.credential.keys).to include @hash[:response]
    end
  end

  describe "#process_user" do
    before { @hash = service.process_user }

    it "should save a user to the database" do
      expect(User.count).to eq 1
    end

    it "should return a user" do
      expect(@hash[:response].class).to eq User
    end
  end

  describe "#record_valid?" do
    it "should send :valid? message to record" do
      d = double "record"
      allow(d).to receive(:valid?) { true }
      expect(d).to receive :valid?
      service.record_valid? d
    end

    context "with valid attributes" do
      it "should return true" do
        expect(service.record_valid?(build_user)).to be true
      end
    end

    context "with invalid attributes" do
      let(:service_options) { {} }

      it "should return false" do
        expect(service.record_valid?(build_user)).to be false
      end
    end
  end

  describe "#set_credential_to_user" do
    it "should set the credential's user_id to the user" do
      hash = service.process_user
      service.set_credential_to_user
      expect(build_credential.user_id).to eq hash[:response].id
    end
  end

  describe "#sign_up_process" do
    context "when user is valid" do
      context "when credential is valid" do
        it "should send :process_user message to service" do
          expect(service).to receive :process_user
          service.sign_up_process
        end

        it "should send :process_credential_from_user message to service" do
          expect(service).to receive :process_credential_from_user
          service.sign_up_process
        end

        it "should not send :errors_response message to service" do
          expect(service).not_to receive :errors_response
          service.sign_up_process
        end
      end

      context "when credential is not valid" do
        let(:service_options) { FactoryGirl.attributes_for(:user) }

        it "should not send :process_user message to service" do
          expect(service).not_to receive :process_user
          service.sign_up_process
        end

        it "should not send :process_credential_from_user message to service" do
          expect(service).not_to receive :process_credential_from_user
          service.sign_up_process
        end

        it "should send :errors_response message to service" do
          expect(service).to receive :errors_response
          service.sign_up_process
        end
      end
    end

    context "when user is not valid" do
      let(:service_options) { {} }
      
      it "should not send :process_user message to service" do
        expect(service).not_to receive :process_user
        service.sign_up_process
      end

      it "should not send :process_credential_from_user message to service" do
        expect(service).not_to receive :process_credential_from_user
        service.sign_up_process
      end

      it "should send :errors_response message to service" do
        expect(service).to receive :errors_response
        service.sign_up_process
      end
    end
  end
end
