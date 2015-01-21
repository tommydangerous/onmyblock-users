class MailEnvelope < BaseEnvelope
  attr_reader :bcc,
              :bccname,
              :cc,
              :ccname,
              :deliver_action,
              :files,
              :from,
              :fromname,
              :html,
              :name,
              :reply_to,
              :subject,
              :text,
              :to,
              :toname

  def initialize(opts = {})
    opts.each do |key, value|
      instance_variable_set "@#{key}".to_sym, value
    end
  end
end
