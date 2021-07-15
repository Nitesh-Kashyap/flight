class NotificationMailer < ApplicationMailer
  default from: 'info@flight.com'
  def notification_mailer(booking,airplane,user)
  	@booking = booking
  	@airplane = airplane
  	@user = user
    mail(to: @user.email,:subject => "Your ticket is succesfully booked!")
  end

  def reset_mailer(user,link)
  	@user = user
  	@link = link
  	mail(to: @user.email,:subject => "Reset Password.")
  end
end
