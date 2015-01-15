class Resource
  attr_accessor :location
  attr_writer :attributes, :status

  def initialize(controller)
    @controller = controller
  end

  def attributes
    if @attributes.nil?
      hash = params.merge("#{name}" => params.except(:action, :controller, :id))
      @attributes = hash.require(name).permit!
    end
    @attributes
  end

  def build
    factory.new attributes: attributes
  end

  def find
    finder.find id
  end

  def id
    params[foreign_key] || params[:id]
  end

  def name
    controller_name.singularize.to_sym
  end

  def path(record)
    controller.send route, record
  end

  def search(method = :all, *args)
    finder.send(method, *args)
  end

  def serialize(record)
    if serializer
      serializer.new record: record
    else
      record
    end
  end

  def status
    @status ||= :ok
  end

  private

  attr_reader :controller

  delegate :controller_name,
           :controller_path,
           :dependencies,
           :params,
           to: :controller

  def factory
    dependencies[name]
  end

  def finder
    dependencies[pluralized_name]
  end

  def foreign_key
    name.to_s.foreign_key.to_sym
  end

  def pluralized_name
    name.to_s.pluralize.to_sym
  end

  def route
    controller_path.singularize.concat("_path").gsub(/\W+/, "_")
  end

  def serializer
    dependencies["#{name}_serializer".to_sym]
  rescue Payload::UndefinedDependencyError
    nil
  end
end
