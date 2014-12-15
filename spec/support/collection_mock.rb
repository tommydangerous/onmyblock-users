class CollectionMock
  COLLECTION = {}

  def initialize(opts = {})
    opts.each do |name, value|
      define_singleton_method(name) { instance_variable_get("@#{name}") }
    end
    update opts
  end

  def self.all
    COLLECTION.values
  end

  def self.create(opts = {})
    if opts[:id]
      pk = opts[:id]
    else
      pk = Time.now.to_s
    end
    obj = CollectionMock.new opts
    COLLECTION[obj.id] = obj
  end

  def self.count
    COLLECTION.size
  end

  def self.destroy_all
    COLLECTION.clear
  end

  def self.find(pk)
    CollectionMock.find_by id: pk
  end

  def self.find_by(opts = {})
    CollectionMock.where(opts).first
  end

  def self.where(opts = {})
    record = COLLECTION.select do |key, value|
      found = true
      opts.each do |query_key, query_value|
        if value.send(query_key) != query_value
          found = false
          break
        end
      end
      found
    end
    record.values
  end

  def destroy
    COLLECTION.delete id
  end

  def id
    @id ||= Time.now.to_s
  end

  def save
    COLLECTION[id] = self
  end

  def try(message)
    begin
      send message
    rescue Exception => e
      p e
    end
  end

  def update(opts)
    opts.each do |name, value|
      instance_variable_set "@#{name}".to_sym, value
    end
  end
end
