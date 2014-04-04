class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    person = Person.find_or_create_by(name: user.name, email: user.email)
    unite_identities(person)
    user.person = person
    user.save
    session[:user_id] = user.id
    redirect_to meals_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private
  def unite_identities(person)
    name = person.name
    email = person.email
    records = Person.where(email: email)
    if records.size > 1
      primary_keys = records.pluck(:id)
      meal_people = MealPerson.where(person_id: primary_keys)
      meal_people.each do |m_p|
        m_p.person_id = person.id
        m_p.save
      end
      meal_recipes = MealRecipe.where(person_id: primary_keys)
      meal_recipes.each do |m_r|
        m_r.person_id = person_id
        m_r.save
      end
      records.destroy_all
    end
    person
  end
end