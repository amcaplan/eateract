class CreateTopicLinks < ActiveRecord::Migration
  def change
    create_table :topic_links do |t|
      t.references :topic, index: true
      t.references :link, index: true

      t.timestamps
    end
  end
end
