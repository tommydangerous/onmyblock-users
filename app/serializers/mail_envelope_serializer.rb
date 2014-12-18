class MailEnvelopeSerializer < ActiveModel::Serializer
  attributes :mailer_action, :mailer_name, :payload

  def mailer_action
    object.action
  end

  def mailer_name
    object.mailer
  end

  def payload
    object.instance_values.symbolize_keys.except(:action).except(:mailer)
  end
end
