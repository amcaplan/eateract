class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show]

  # GET /recipes/search.json
  def search
    json_recipe = Yummly.search(params[:query])
    if json_recipe
      respond_to do |format|
        format.json { render json: json_recipe.json, status: 200 }
      end
    else
      respond_to do |format|
        format.json { render text: "Error", status: 500}
      end
    end
  end

  # GET /recipes/1.json
  def get_details
    json_recipe = Yummly.find(params[:recipe_id])
    if json_recipe
      respond_to do |format|
        format.json { render json: json_recipe, status: 200}
      end
    else
      respond_to do |format|
        format.json { render text: "Error", status: 500}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :cuisine_type, :url)
    end
end
