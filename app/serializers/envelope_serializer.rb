class EnvelopeSerializer < ActiveModel::Serializer
  attributes :errors, :metadata, :resource
end
