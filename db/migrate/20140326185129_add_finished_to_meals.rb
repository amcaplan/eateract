class AddFinishedToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :finished, :boolean
  end
end
