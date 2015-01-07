require "rails_helper"

RSpec.describe Resourceful, type: :controller do
  described_class.tap do |mod|
    controller ApplicationController do
      include mod
    end
  end

  before do
    dependencies = Payload::RailsLoader.load
                   .service(:examples) { finder }
                   .factory(:example) do |container|
                     container[:examples].new container[:attributes]
                   end

    allow(controller).to receive(:dependencies).and_return dependencies

    allow(controller).to receive(:controller_name).and_return "examples"
    allow(controller).to receive(:controller_path).and_return "api/examples"

    def controller.api_example_path(record)
      "/api/examples/#{record.id}"
    end
  end

  let(:finder)  { double "finder", all: records, new: factory }
  let(:records) { [] }
  let(:factory) { double "factory", id: 1, save: saved, errors: {} }
  let(:saved)   { true }

  describe "#create" do
    before { post :create, example: attributes }

    let(:attributes) { { test: "value" } }

    context "with valid attributes" do
      it { should respond_with :created }

      it "should set the Location header" do
        expect(response.headers.fetch "Location").to eq "/api/examples/1"
      end

      it "should call save on the resource" do
        expect(factory).to have_received :save
      end
    end

    context "with invalid attributes" do
      before { allow(factory).to receive(:save).and_return false }

      let(:saved) { false }

      it { should respond_with :unprocessable_entity }

      it "should call save on the resource" do
        expect(factory).to have_received :save
      end
    end
  end

  describe "#destroy" do
    context "with a valid resource id" do
      before do
        allow(finder).to receive(:find).with("1").and_return factory
        allow(factory).to receive :destroy
        allow(factory).to receive(:destroyed?).and_return true
        delete :destroy, id: 1
      end

      it { should respond_with :success }
    end

    context "with an invalid resource id" do
      before do
        allow(finder).to receive(:find).with("1").and_return nil
        delete :destroy, id: 1
      end

      it { should respond_with :not_found }
    end

    context "with an undestroyable record" do
      before do
        allow(finder).to receive(:find).with("1").and_return factory
        allow(factory).to receive :destroy
        allow(factory).to receive(:destroyed?).and_return false
        delete :destroy, id: 1
      end

      it { should respond_with :unprocessable_entity }
    end
  end

  describe "#index" do
    before { get :index }

    it { should respond_with :success }

    it "should set :resource in view" do
      expect(controller.view[:resource]).to eq records
    end
  end

  describe "#show" do
    context "with a valid resource id" do
      before do
        allow(finder).to receive(:find).with("1").and_return factory
        get :show, id: 1
      end

      it { should respond_with :success }
    end

    context "with an invalid resource id" do
      before do
        allow(finder).to receive(:find).with("1").and_return nil
        get :show, id: 1
      end

      it { should respond_with :not_found }
    end
  end

  describe "#update" do
    context "with a valid resource id and attributes" do
      before do
        allow(finder).to receive(:find).with("1").and_return factory
        allow(factory).to receive(:update_attributes)
          .with(attributes)
          .and_return true

        put :update, id: 1, **attributes
      end

      let(:attributes) { { test: "value" } }

      it { should respond_with :success }
    end

    context "with an invalid resource id" do
      before do
        allow(finder).to receive(:find).with("1").and_return nil
        get :show, id: 1
      end

      it { should respond_with :not_found }
    end

    context "with invalid attributes" do
      before do
        allow(finder).to receive(:find).with("1").and_return factory
        allow(factory).to receive(:update_attributes)
          .with(attributes)
          .and_return false

        put :update, id: 1, **attributes
      end

      let(:attributes) { { test: "value" } }

      it { should respond_with :unprocessable_entity }
    end
  end
end
