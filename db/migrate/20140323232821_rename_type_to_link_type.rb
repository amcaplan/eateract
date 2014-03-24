class RenameTypeToLinkType < ActiveRecord::Migration
  def change
    change_table :links do |t|
      t.rename :type, :link_type
    end
  end
end
