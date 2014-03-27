class AddMessageToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :message, :text
  end
end
