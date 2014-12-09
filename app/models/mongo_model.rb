module MongoModel
  def included(base)
    base.class_eval do
      include Mongoid::Document
      include Mongoid::Timestamps
    end
  end
end
