class User < ActiveRecord::Base
	
	def self.create_with_omniauth(auth)
    	create! do |user|
      		user.provider = auth["provider"]
		    user.uid = auth["uid"]
		    user.first_name = auth["info"]["name"]
			user.username = auth["info"]["username"]
    	end
  	end
	
end
