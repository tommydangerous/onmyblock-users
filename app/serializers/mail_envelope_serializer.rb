class MailEnvelopeSerializer < ActiveModel::Serializer
  attributes :mailer

  def mailer
    {
      action:  object.action,
      name:    object.name,
      payload: payload
    }
  end

  private

  def payload
    object.instance_values.symbolize_keys.except(:action).except(:name)
  end
end
