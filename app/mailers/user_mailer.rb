class UserMailer < ActionMailer::Base
  default from: "norepley@akubi.net"

  def notification(user:, title:, body:)
    return unless user.email
    @body = body

    mail to: user.email, subject: title
  end

  def checkin(event)
    @user     = event.user
    @location = event.location
    @event    = event

    mail to: "#{@user.email}, #{@user.other_email}, #{Rails.application.secrets.master_email}", subject: "#{@location.name}へ入室しました。"
  end

  def checkout(event)
    @user     = event.user
    @location = event.location
    @event    = event

    mail to: "#{@user.email}, #{@user.other_email}, #{Rails.application.secrets.master_email}", subject: "#{@location.name}から退出しました。"
  end

end
