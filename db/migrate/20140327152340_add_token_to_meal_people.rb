class AddTokenToMealPeople < ActiveRecord::Migration
  def change
    add_column :meal_people, :token, :string
  end
end
