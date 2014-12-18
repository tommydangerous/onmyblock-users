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
end
