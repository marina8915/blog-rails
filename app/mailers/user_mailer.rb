class UserMailer < ApplicationMailer
  require 'mailgun-ruby'

  API_KEY = ENV['MAILGUN_API_KEY']
  MAILGUN_DOMAIN = ENV['MAILGUN_DOMAIN']
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password.subject
  #
  def reset_password(user)
    @user = user
    mg_client = Mailgun::Client.new API_KEY
    message_params = { from: 'admin@blog-ror-1.herokuapp.com',
                       to: @user.email,
                       subject: 'Reset password instructions',
                       text: "To reset your password, click the URL below: https://blog-ror-1.herokuapp.com/password_resets/#{@user.password_reset_token}" }
    mg_client.send_message MAILGUN_DOMAIN, message_params
  end
end
