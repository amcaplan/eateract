class AlterMealRecipes < ActiveRecord::Migration
  def up
    add_reference :meal_recipes, :person, index: true
    remove_column :meal_recipes, :quantity
  end
  def down
    add_column :meal_recipes, :quantity, :decimal
    remove_reference :meal_recipes, :person
  end
end
