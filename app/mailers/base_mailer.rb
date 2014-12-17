class BaseMailer < ActionMailer::Base
  default from: "OnMyBlock <info@onmyblock.com>"

  private

  def host
    ENV.fetch "HOST", "onmyblock.com"
  end
end
