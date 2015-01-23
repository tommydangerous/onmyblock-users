module Resourceful
  extend ActiveSupport::Concern

  included do
    before_action :build_record, only: %i(create)
    before_action :find_record,  only: %i(destroy show update)
  end

  attr_accessor :record

  def create
    render_resource :save do
      resource.status = :created
      resource.location = resource.path record
    end
  end

  def destroy
    record.destroy
    render_resource :destroyed?
  end

  def index
    view[:resource] = records
    render_resource
  end

  def show
    render_resource
  end

  def update
    render_resource :update_attributes, resource.attributes
  end

  def view
    @view ||= {
      errors:   {},
      resource: resource.serialize(record)
    }
  end

  private

  def build_record
    @record ||= resource.build
  end

  def find_record
    @record ||= resource.find || not_found
  end

  def records
    @records ||= resource.search
  end

  def resource
    @resource ||= dependencies[:resource].new controller: self
  end

  def render_resource(method = nil, *args)
    if method.nil? || record.send(method, *args)
      resource.status = :ok
      yield if block_given?
    else
      resource.status = :unprocessable_entity
      view[:errors] = record.errors
    end
    render render_options
  end

  def render_options
    {
      json:     render_options_json,
      location: resource.location,
      status:   resource.status
    }
  end

  def render_options_json
    if params[:callback]
      ResponseEnvelopeSerializer.new(envelope).serializable_hash.to_json
    else
      envelope
    end
  end

  def view_with_status
    view.update metadata: { status: resource.status }
  end

  def envelope
    ResponseEnvelope.new view_with_status
  end
end
