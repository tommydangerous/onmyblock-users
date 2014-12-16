class EnvelopeSerializer < ActiveModel::Serializer
  attributes :resource, :metadata, :errors
end
