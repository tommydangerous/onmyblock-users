require "rails_helper"

RSpec.describe Resource do
  subject { described_class.new controller }

  let :controller do
    double "controller", controller_name: "examples",
                         controller_path: "test/examples",
                         dependencies: dependencies,
                         params: params
  end

  let(:dependencies) do
    container = { example: factory,
                  examples: finder,
                  example_serializer: serializer }

    def container.[](key)
      super.tap do |value|
        if value.nil?
          fail Payload::UndefinedDependencyError
        end
      end
    end

    container
  end

  let(:factory)      { double "factory", new: true }
  let(:finder)       { double "finder", find: true }
  let(:serializer)   { nil }

  let(:attributes) { { test: "testing" } }

  let :params do
    ActionController::Parameters.new example: attributes, id: 1
  end

  it { should respond_to :attributes= }
  it { should respond_to :location }
  it { should respond_to :location= }

  context "#attributes" do
    it "should permit all attributes under the resource name" do
      expect(controller.params).to receive(:require)
        .with(:example)
        .and_return params

      expect(params).to receive :permit!

      subject.attributes
    end

    it "should allow attributes to be updated" do
      expect(subject.attributes[:missing]).to be_nil
      subject.attributes.update missing: true
      expect(subject.attributes[:missing]).not_to be_nil
    end
  end

  context "#build" do
    it "should lookup a factory from dependencies" do
      expect(dependencies).to receive(:[])
        .with(:example)
        .and_return factory

      subject.build
    end

    it "should build a factory with specified attributes" do
      expect(factory).to receive(:new).with attributes: attributes
      subject.build
    end
  end

  context "#find" do
    it "should lookup a finder from dependencies" do
      expect(dependencies).to receive(:[])
        .with(:examples)
        .and_return finder

      subject.find
    end

    it "should find a record with specified id" do
      expect(finder).to receive(:find).with params[:id]
      subject.find
    end
  end

  context "#id" do
    it "should try looking up by foreign_key first" do
      params[:example_id] = "test"
      params[:id] = "never gets here"
      expect(subject.id).to eq "test"
    end

    it "should lookup by :id otherwise" do
      params[:id] = "example"
      expect(subject.id).to eq "example"
    end
  end

  context "#name" do
    it "should parse the singularized name" do
      expect(subject.name).to eq :example
    end
  end

  context "#path" do
    it "should pass object to the correct route" do
      object = double "object"
      expect(controller).to receive(:test_example_path).with object
      subject.path object
    end
  end

  context "#search" do
    it "should search the finder with :all by default" do
      expect(finder).to receive :all
      subject.search
    end

    it "should search the finder with specified a method" do
      expect(finder).to receive :none
      subject.search :none
    end

    it "should search the finder with specified a method and args" do
      expect(finder).to receive(:order).with id: :desc
      subject.search :order, id: :desc
    end
  end

  context "#status" do
    it "should be ok by default" do
      expect(subject.status).to eq :ok
    end

    it "should be writable" do
      subject.status = :test
      expect(subject.status).to eq :test
    end
  end

  describe "#serialize" do
    let(:object) { double "object" }

    context "when serializer exists" do
      let(:serializer) { double "serialize", new: "serialized" }

      it "should return the serializer instance" do
        expect(subject.serialize object).to eq "serialized"
      end
    end

    context "when serializer does not exist" do
      it "should return the object" do
        expect(subject.serialize object).to eq object
      end
    end
  end
end
