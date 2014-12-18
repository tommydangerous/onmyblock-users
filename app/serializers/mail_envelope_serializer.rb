class MailEnvelopeSerializer < ActiveModel::Serializer
  attributes :action, :mailer, :payload

  def payload
    object.instance_values.symbolize_keys.except(:action).except(:mailer)
  end
end
