class ApplicationMailer < ActionMailer::Base
  default from: Settings.admin.email.default
  layout "mailer"
end
