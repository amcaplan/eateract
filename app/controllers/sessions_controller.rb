class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    person = Person.find_or_create_by(name: user.name, email: user.email)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
