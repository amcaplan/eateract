# {
#   "utf8"=>"✓",
#   "authenticity_token"=>"HTDe2rX1BcRlDsp4O2td6gOsSIIHcLzc428b95CBRMc=",
#   "person"=>[
#     {
#       "name"=>"Ariel Caplan",
#       "email"=>"ariel.caplan@mail.yu.edu",
#       "host_relationship"=>"friend"
#     },
#     {
#       "name"=>"Ariella Gottesman",
#       "email"=>"aagottesman@gmail.com",
#       "host_relationship"=>"relative"
#     },
#     {"name"=>"", "email"=>"", "host_relationship"=>""},
#     {"name"=>"", "email"=>"", "host_relationship"=>""},
#     {"name"=>"", "email"=>"", "host_relationship"=>""},
#     {"name"=>"", "email"=>"", "host_relationship"=>""},
#     {"name"=>"", "email"=>"", "host_relationship"=>""},
#     {"name"=>"", "email"=>"", "host_relationship"=>""}
#   ],
#   "meal"=>{
#     "topic_id"=>"2"
#     },
#   "links"=>["1", "4", "6"],
#   "recipes"=>[
#     "recipePull-apart-spicy-cheese-bread-308317",
#     "recipeGarlicky-Party-Bread-with-Herbs-and-Cheese-501520",
#     "recipeCrisp-rosemary-flatbread-307140",
#     "recipePull-apart-spicy-cheese-bread-308317",
#     "recipeGarlicky-Party-Bread-with-Herbs-and-Cheese-501520",
#     "recipeCrisp-rosemary-flatbread-307140"
#   ],
#   "recipe_query"=>"bread",
#   "commit"=>"Submit meal",
#   "action"=>"create",
#   "controller"=>"meals"
# }

class MealsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :dont_show_new_meal_button, only: [:new, :edit]

  # GET /meals
  # GET /meals.json
  def index
    if session[:user_id]
      @meals = Meal.joins(:meal_people).where("meal_people.person_id" => current_user)
    end
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @meal = Meal.find(params[:id])
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
    unless @host && @meal.hosted_by?(@host)
      redirect_to meals_url
    end
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
  end

  # POST /meals
  # POST /meals.json
  def create
    @update = false
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

  alias_method :update, :create
  def update
    @update = true
    create_or_update
    @meal.save

    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
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
      @meal = Meal.create(meal_params) if @create
      @meal.people = people
      @meal.meal_people.each { |mp|
        mp.host_relationship = params[:person].find{|person|
          Person.find_by(name: person[:name], email: person[:email]).id == mp.person_id
        }[:host_relationship]
      }.map(&:save)
      @meal.recipes = recipes
      @meal.link_ids = params[:meal][:link_ids]
      @meal.time = Chronic.parse("#{params[:meal][:date]} #{params[:meal][:time]}")

      params[:commit] == "Stash changes" if recipes.empty? || people.empty?
    end
end
