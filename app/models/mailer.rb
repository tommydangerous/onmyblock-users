class Mailer
  include ActiveModel::Model

  attr_accessor :deliver_action, :name, :payload

  validates_presence_of :deliver_action, :name, :payload

  def save
    deliver
    true
  rescue StandardError => e
    errors.add :send_failed, e.to_s
    false
  end

  private

  def deliver
    mailer.send(deliver_action, payload).deliver
  end

  def mailer
    Object.const_get "#{name}_mailer".camelize
  end
end
