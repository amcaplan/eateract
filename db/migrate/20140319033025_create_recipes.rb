class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :cuisine_type
      t.string :url

      t.timestamps
    end
  end
end
