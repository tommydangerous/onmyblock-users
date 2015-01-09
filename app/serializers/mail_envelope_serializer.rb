class MailEnvelopeSerializer < ActiveModel::Serializer
  attributes :mailer

  def mailer
    {
      deliver_action:  object.deliver_action,
      name:            object.name,
      payload:         payload
    }
  end

  private

  def payload
    object.instance_values.symbolize_keys.except(:deliver_action).except(:name)
  end
end
