class CreateTales < ActiveRecord::Migration
  def self.up
    create_table :tales do |t|
      	t.string 	:title
		t.text 		:description
		t.integer	:user_id
		t.text		:images
		  
    	t.timestamps
    end
  end

  def self.down
    drop_table :tales
  end
end
