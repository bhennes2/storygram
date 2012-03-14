class AddDateToTale < ActiveRecord::Migration
  def self.up
  	add_column :tales, :date, :date
  end

  def self.down
  	remove_column :tales, :date, :date
  end
end
