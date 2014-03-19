class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :type
      t.string :url
      t.text :summary

      t.timestamps
    end
  end
end
