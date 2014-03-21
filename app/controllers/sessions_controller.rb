class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    person = Person.find_or_create_by(email: user.email)
    person.name = user.name
    person.save
    user.person = person
    user.save
    session[:user_id] = user.id
    redirect_to session[:original_url]
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
