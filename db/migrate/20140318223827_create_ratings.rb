class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :number
      t.references :meal, index: true
      t.references :person, index: true

      t.timestamps
    end
  end
end
