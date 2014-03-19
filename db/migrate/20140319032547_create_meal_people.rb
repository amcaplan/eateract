class CreateMealPeople < ActiveRecord::Migration
  def change
    create_table :meal_people do |t|
      t.references :meal, index: true
      t.references :person, index: true
      t.boolean :host
      t.boolean :attending
      t.string :host_relationship

      t.timestamps
    end
  end
end
