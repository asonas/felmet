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
    subject   = "【box for Designers 入退室管理システムからのお知らせ】#{@location.name}へ入室しました。"

    if @user.internal?
      mail to: "#{@user.email}", subject: subject
    else
      mail to: "#{@user.email}, #{@user.other_email}, #{Rails.application.secrets.master_email}", subject: subject
    end
  end

  def checkout(event)
    @user     = event.user
    @location = event.location
    @event    = event
    subject   = "【box for Designers 入退室管理システムからのお知らせ】#{@location.name}へ退室しました。"

    if @user.internal?
      mail to: "#{@user.email}", subject: subject
    else
      mail to: "#{@user.email}, #{@user.other_email}, #{Rails.application.secrets.master_email}", subject: subject
    end
  end

end
