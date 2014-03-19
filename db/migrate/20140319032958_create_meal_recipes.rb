class CreateMealRecipes < ActiveRecord::Migration
  def change
    create_table :meal_recipes do |t|
      t.references :meal, index: true
      t.references :recipe, index: true
      t.decimal :quantity

      t.timestamps
    end
  end
end
