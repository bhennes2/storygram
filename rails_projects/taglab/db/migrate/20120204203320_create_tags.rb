class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :time
      t.string :title
      t.string :notes
      t.string :location
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tags
  end
end
