class MealsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:show, :change_meal_details]
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :dont_show_new_meal_button, only: [:new, :edit]

  # GET /meals
  # GET /meals.json
  def index
    Meal.joins(:meal_people).where("meal_people.person_id" => current_user).
      select{|meal| !meal.finished && meal.time && meal.time < Time.now}.map(&:delete)
    meals = Meal.joins(:meal_people).where("meal_people.person_id" => current_user.person.id)
    @upcoming_meals = meals.select{|meal| meal.finished && meal.time > Time.now}
    @past_meals = meals.select{|meal| meal.finished && meal.time < Time.now}
    @unfinished_meals = meals.select{|meal| !meal.finished && meal.host.pluck(:id)[0] == session[:user_id]}
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])
    if current_user
      session[:invite] = nil
      @person = Person.find_by(email: User.where(id: current_user).pluck(:email))
    else
      session[:invite] ||= params[:invite]
      @meal_person = MealPerson.find_by(token: session[:invite])
      @person = @meal_person.person if @meal_person
    end
    if @meal && @person && @meal.people.include?(@person)
      @meal_person ||= @meal.meal_people.find_by(person_id: @person.id)
      case @meal_person.attending
      when true
        render 'show'
      when nil
        render 'respond'
      when false
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @host = User.find(session[:user_id]).person
    redirect_to root_url unless @host
    @people = [Person.new, Person.new, Person.new]
  end

  # GET /meals/1/edit
  def edit
    @host = User.find(session[:user_id]).person
    if @host && @meal.hosted_by?(@host) && !@meal.finished
      @people = @meal.people.reject{|person| person == @host} << Person.new
      @topic_id = @meal.topic_id
      @link_ids = @meal.links.pluck(:id)
      recipes = @meal.recipes.pluck(:url, :name)
      recipes.map! do |recipe|
        [recipe[0][29..-1], recipe[1]]
      end
      @recipes = Hash[recipes]
      time = @meal.time
      if time
        time = time.to_datetime.rfc3339.split("T")
        @date, @time = time[0], time[1][0..-7]
      end
    else
      redirect_to meals_url
    end
  end

  # POST /meals
  # POST /meals.json
  def create
    @create = true
    create_or_update

    respond_to do |format|
      if @meal.save
        if params[:commit] == "Submit meal"
          finish_meal
        end
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @create = false
    create_or_update
    @meal.save

    respond_to do |format|
      if @meal.update(meal_params)
        if params[:commit] == "Submit meal"
          finish_meal
        end
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /meals/1/guests/1
  def change_meal_details
    meal_person = MealPerson.find_by(token: session[:invite])
    meal = Meal.find(params[:meal_id])
    case params[:commit]
    when "Yes, I'm in!"
      meal_person.attending = true
      meal_person.save
      redirect_to meal
    when "Sorry, no..."
      meal_person.attending = false
      meal_person.save
      redirect_to root_url
    else # Signing up for recipes
      person_id = current_user ? session[:user_id] : meal_person.person.id
      meal_recipes = MealRecipe.where(id: params[:meal_recipes])
      meal_recipes.each{|mp| mp.person = person_id}.each(&:save)
      if current_user
        redirect_to Meal.find(params[:meal_id])
      else
        redir_string = "#{root_url}meals/#{params[:meal_id]}?invite=#{session[:invite]}"
        redirect_to redir_string
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def generate_recipes(recipes)
      if recipes.empty?
        []
      else
        ActiveSupport::JSON.decode(recipes).map do |id, name|
          Recipe.find_or_create_by(name: name, url: "http://www.yummly.com/recipe/" + id)
        end
      end
    end

    def generate_people(people)
      people.reject!{|person| person[:name].empty? || person[:email].empty?}
      people = people.select { |person|
        !person[:name].empty? && person[:email].match(/.+@.+\..+/i)
      }.map do |person|
        existing_person = Person.find_by(email: person[:email])
        if existing_person && (existing_person.user || existing_person.name == person[:name])
          existing_person
        else
          Person.create(name: person[:name], email: person[:email])
        end
      end
    end

    def dont_show_new_meal_button
      @dont_show_new_meal_button = true
    end

    def redirect_if_not_logged_in
      redirect_to root_url unless session[:user_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:topic_id, :message)
    end

    def create_or_update
      recipes = generate_recipes(params[:recipe_list])
      people = generate_people(params[:person])
      if @create
        @meal = Meal.create(meal_params)
      end
      @meal.people = people
      binding.pry
      @meal.meal_people.each { |mp|
        mp.host_relationship = params[:person].find{|person|
          Person.find_by(name: person[:name], email: person[:email]).id == mp.person_id
        }[:host_relationship]
      }.map(&:save)
      @meal.recipes = recipes
      @meal.link_ids = params[:meal][:link_ids]
      Chronic.time_class = Time.zone
      @meal.time = Chronic.parse("#{params[:meal][:date]} #{params[:meal][:time]}")

      params[:commit] = "Stash changes" if recipes.empty? || people.empty? || !@meal.time
    end

    def finish_meal
      @meal.finished = true
      @meal.save
      @meal.meal_people_guests.each do |guest|
        InvitationMailer.invited_email(guest).deliver
      end
    end
end
