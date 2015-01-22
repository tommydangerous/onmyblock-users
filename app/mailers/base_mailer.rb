class BaseMailer < ActionMailer::Base
  private

  def capture_options(opts)
    if opts.class == String
      @options = JSON.parse opts, symbolize_names: true
    else
      @options = opts
    end
  end

  def from
    @options[:from]
  end

  def subject
    @options[:subject]
  end

  def to
    @options[:to]
  end
end
