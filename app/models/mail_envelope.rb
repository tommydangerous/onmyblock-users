class MailEnvelope < BaseEnvelope
  attr_reader :action,
              :bcc,
              :bccname,
              :cc,
              :ccname,
              :files,
              :from,
              :fromname,
              :html,
              :mailer,
              :reply_to,
              :subject,
              :text,
              :to,
              :toname

  def initialize(opts = {})
    opts.each do |name, value|
      instance_variable_set "@#{name}".to_sym, value
    end
  end
end
