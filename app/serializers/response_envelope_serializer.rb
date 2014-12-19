class ResponseEnvelopeSerializer < ActiveModel::Serializer
  attributes :errors, :metadata, :resource
end
