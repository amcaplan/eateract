class RemoveCuisineTypes < ActiveRecord::Migration
  def up
    remove_column(:recipes, :cuisine_type)
    remove_column(:meals, :cuisine_type)
  end

  def down
    add_column(:recipes, :cuisine_type, :string)
    add_column(:meals, :cuisine_type, :string)
  end
end
