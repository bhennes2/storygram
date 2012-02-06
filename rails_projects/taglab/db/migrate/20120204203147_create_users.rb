class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :about
      t.string :age
      t.string :sex
      t.string :zip_code

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
