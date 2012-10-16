class UserMailer < ActionMailer::Base
  default from: "groups@wegroup.com"

  def signup_confirmation(user)
    @user=user

    mail to: user.email, subject: "Welcome to WeGroup!"
  end
end
