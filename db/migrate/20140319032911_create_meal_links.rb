class CreateMealLinks < ActiveRecord::Migration
  def change
    create_table :meal_links do |t|
      t.references :meal, index: true
      t.references :link, index: true

      t.timestamps
    end
  end
end
