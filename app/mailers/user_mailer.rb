class UserMailer < ActionMailer::Base
  default from: "norepley@akubix.com"

  def notification(user:, title:, body:)
    return unless user.email
    @body = body

    mail to: user.email, subject: title
  end
end
