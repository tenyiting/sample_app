class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #

  def account_activation user
    @user = user
    mail to: user.email, subject: t(:mail_activation_acc)
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t(:mail_reset_password)
  end
end
