class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :time
      t.references :topic, index: true
      t.string :cuisine_type

      t.timestamps
    end
  end
end
