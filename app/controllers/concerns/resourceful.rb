module Resourceful
  extend ActiveSupport::Concern

  included do
    before_action :build_record, only: %i(create new)
    before_action :find_record,  only: %i(destroy show update)
  end

  attr_accessor :record

  private

  def build_record
    @record ||= resource.build
  end

  def envelope
    ResponseEnvelope.new view_with_status
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
      json: envelope,
      status: resource.status,
      location: resource.location
    }
  end

  def view
    @view ||= {
      errors:   {},
      resource: resource.serialize(record)
    }
  end

  def view_with_status
    view.update metadata: { status: resource.status }
  end
end
