module MongoModel
  def included(base)
    base.class_eval do
      include Mongoid::Document
      include Mongoid::Timestamps
      include Mongoid::Attributes::Dynamic
    end
  end
end
