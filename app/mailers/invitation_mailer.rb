class InvitationMailer < ActionMailer::Base
  default from: "The Eateract Team <eateract@gmail.com>"

  def invited_email(meal_person)
    @meal_person = meal_person
    @person = meal_person.person
    @meal = meal_person.meal
    attachments.inline['logo.png'] = File.read(File.expand_path('app/assets/images/logo_email.png'))
    mail(to: "#{@person.name} <#{@person.email}>",
      subject: "You're Invited to a Meal!") 
  end
end
