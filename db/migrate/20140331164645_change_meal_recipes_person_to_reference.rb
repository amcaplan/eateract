class ChangeMealRecipesPersonToReference < ActiveRecord::Migration
  def up
    remove_column(:meal_recipes, :person_id)
    add_column(:meal_recipes, :person, :reference)
  end

  def down
    remove_column(:meal_recipes, :person)
    add_column(:meal_recipes, :person_id, :integer)
  end
end
