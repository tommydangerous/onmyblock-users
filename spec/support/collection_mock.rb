class CollectionMock
  COLLECTION = {}

  def initialize(opts = {})
    opts.each do |name, _value|
      define_singleton_method(name) { instance_variable_get("@#{name}") }
    end
    update opts
  end

  def self.all
    COLLECTION.values
  end

  def self.create(opts = {})
    obj = new opts
    COLLECTION[obj.id] = obj
  end

  def self.count
    COLLECTION.size
  end

  def self.destroy_all
    COLLECTION.clear
  end

  def self.find(pk)
    find_by id: pk
  end

  def self.find_by(opts = {})
    where(opts).first
  end

  def self.where(opts = {})
    record = COLLECTION.select do |_key, value|
      opts.all? do |query_key, query_value|
        value.send(query_key) == query_value
      end
    end

    record.values
  end

  def destroy
    COLLECTION.delete id
  end

  def errors
    {}
  end

  def id
    @id ||= Time.now.to_s
  end

  def save
    COLLECTION[id] = self
  end

  def try(message)
    send message
  rescue StandardError => e
    p e
  end

  def update(opts)
    opts.each do |name, value|
      instance_variable_set "@#{name}".to_sym, value
    end
  end
end
