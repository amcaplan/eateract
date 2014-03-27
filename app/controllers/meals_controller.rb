class MealsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:show, :signup_for_recipes]
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :dont_show_new_meal_button, only: [:new, :edit]

  # GET /meals
  # GET /meals.json
  def index
    Meal.joins(:meal_people).where("meal_people.person_id" => current_user).
      select{|meal| !meal.finished && meal.time && meal.time < Time.now}.map(&:delete)
    meals = Meal.joins(:meal_people).where("meal_people.person_id" => current_user)
    @upcoming_meals = meals.select{|meal| meal.finished && meal.time > Time.now}
    @past_meals = meals.select{|meal| meal.finished && meal.time < Time.now}
    @unfinished_meals = meals.select{|meal| !meal.finished && meal.host.pluck(:id)[0] == session[:user_id]}
    puts "upcoming"
    puts @upcoming_meals
    puts "past"
    puts @past_meals
    puts "unfinished"
    puts @unfinished_meals
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])
    @person = if current_user
      Person.find_by(email: User.where(id: current_user).pluck(:email))
    else
      session[:token] = params[:invite]
      mp = MealPerson.find_by(token: params[:invite])
      mp.person if mp
    end
    redirect_to root_url unless @meal && @person
    @meal_person = @meal.meal_people.find_by(person_id: @person.id) if @person
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
          @meal.finished = true
          @meal.save
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
          @meal.finished = true
          @meal.save
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
  def signup_for_recipes
    person_id = if current_user
      params[:person_id]
    else
      MealPerson.find_by(token: session[:token]).person.id
    end
    meal_recipes = MealRecipe.where(id: params[:meal_recipes])
    meal_recipes.each{|mp| mp.person_id = person_id}.each(&:save)
    if current_user
      redirect_to Meal.find(params[:meal_id])
    else
      redir_string = "#{root_url}meals/#{params[:meal_id]}?invite=#{session[:token]}"
      redirect_to redir_string
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
        Person.find_or_create_by(name: person[:name], email: person[:email])
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
      params.require(:meal).permit(:topic_id)
    end

    def create_or_update
      recipes = generate_recipes(params[:recipe_list])
      people = generate_people(params[:person])
      if @create
        @meal = Meal.create(meal_params)
      end
      @meal.people = people
      @meal.meal_people.each { |mp|
        mp.host_relationship = params[:person].find{|person|
          Person.find_by(name: person[:name], email: person[:email]).id == mp.person_id
        }[:host_relationship]
      }.map(&:save)
      @meal.recipes = recipes
      @meal.link_ids = params[:meal][:link_ids]
      @meal.time = Chronic.parse("#{params[:meal][:date]} #{params[:meal][:time]}")

      params[:commit] = "Stash changes" if recipes.empty? || people.empty? || !@meal.time
    end
end
