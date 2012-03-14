class ChangeDateTypeTales < ActiveRecord::Migration
  def self.up
  	change_column :tales, :date, :string
  end

  def self.down
  	change_column :tales, :date, :date
  end
end
