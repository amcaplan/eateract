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
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @host = User.find(session[:user_id]).person
    if @host
      @stage = 'guests'
    else
      redirect_to root_url
    end
  end

  # GET /meals/1/edit
  def edit
    @host = User.find(session[:user_id]).person
    @meal = Meal.find(params[:id])
    if @host && @meal.hosted_by?(@host)
      @stage = 'topic'
    end
  end

  # POST /meals/submit_guests
  def submit_guests
    meal = Meal.create
    meal.host = User.find(session[:user_id])
    relationships = []
    guests = params[:guests].map do |info_hash|
      person = Person.find_or_create_by(email: info_hash[:email])
      person.name = info_hash[:name]
      relationships << info_hash[:relationship]
      person
    end
    respond_to do |format|
      if guests.all?(&:save)
        meal.add_guests(guests, relationships)
        session[:meal_id] = meal.id
        format.html { render action: 'new', notice: "Meal started!  You have invited #{guests.count} guests." }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # POST /meals
  # POST /meals.json
  def create
    raise params.inspect
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    raise params.inspect
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

    def dont_show_new_meal_button
      @dont_show_new_meal_button = true
    end

    def redirect_if_not_logged_in
      redirect_to root_url unless session[:user_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:time, :topic_id, :cuisine_type)
    end
end
