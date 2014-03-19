class ChangeRatingNumbersToFloats < ActiveRecord::Migration
  def up
    change_column :ratings, :number, :float
  end

  def down
    change_column :ratings, :number, :integer
  end
end
