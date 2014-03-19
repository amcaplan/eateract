class ArielMailer < ActionMailer::Base
  default from: "The Eateract Team <eateract@gmail.com>"

  def welcome(email)
    mail(to: email, body: "HELLO WORLD!")
  end
end
