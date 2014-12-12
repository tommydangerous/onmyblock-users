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

  describe "#save_credential" do
    before { @credential = service.save_credential }
    it "should save a credential to the database" do
      expect(Credential.count).to eq 1
    end

    it "should create a credential that belongs to the user" do
      expect(service.user.credentials).to include @credential
    end

    it "should return a credential" do
      expect(@credential.class).to eq Credential
    end
  end

  describe "#save_credential_from_user" do
    it "should send :set_credential_to_user message to service" do
      expect(service).to receive :set_credential_to_user
      service.save_credential_from_user
    end

    it "should send :save_credential message to service" do
      expect(service).to receive :save_credential
      service.save_credential_from_user
    end
  end

  describe "#save_key_from_credential" do
    before { @key = service.save_key_from_credential }

    it "should save a key to the database" do
      expect(Key.count).to eq 1
    end

    it "should create a key that belongs to the credential" do
      expect(service.credential.keys).to include @key
    end

    it "should return a key" do
      expect(@key.class).to eq Key
    end
  end

  describe "#save_user" do
    before { @user = service.save_user }

    it "should save a user to the database" do
      expect(User.count).to eq 1
    end

    it "should return a user" do
      expect(@user.class).to eq User
    end
  end

  describe "#set_credential_to_user" do
    it "should set the credential's user_id to the user" do
      user = service.save_user
      service.set_credential_to_user
      expect(build_credential.user_id).to eq user.id
    end
  end

  describe "#sign_up_process" do
    context "when user is valid" do
      context "when credential is valid" do
        it "should send :save_user message to service" do
          expect(service).to receive :save_user
          service.sign_up_process
        end

        it "should send :save_credential_from_user message to service" do
          expect(service).to receive :save_credential_from_user
          service.sign_up_process
        end
      end

      context "when credential is not valid" do
        let(:service_options) { FactoryGirl.attributes_for(:user) }

        it "should not send :save_user message to service" do
          expect(service).not_to receive :save_user
          service.sign_up_process
        end

        it "should not send :save_credential_from_user message to service" do
          expect(service).not_to receive :save_credential_from_user
          service.sign_up_process
        end
      end
    end

    context "when user is not valid" do
      let(:service_options) { {} }
      
      it "should not send :save_user message to service" do
        expect(service).not_to receive :save_user
        service.sign_up_process
      end

      it "should not send :save_credential_from_user message to service" do
        expect(service).not_to receive :save_credential_from_user
        service.sign_up_process
      end
    end
  end
end
