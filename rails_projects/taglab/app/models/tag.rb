class Tag < ActiveRecord::Base
	validates :title, :presence => true 
end
