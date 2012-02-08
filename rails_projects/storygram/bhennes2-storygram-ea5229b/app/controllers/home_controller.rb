class HomeController < ApplicationController
  require "instagram"
  
  

  if Rails.env.development?
    CALLBACK_URL = "http://localhost:3000/login"
    CLIENT_ID = "b91ac9d30d814251b62dfa87df40b356"
    CLIENT_SECRET = "fd6595543bdc411a921002cf0f67bb66"
  elsif Rails.env.production?
    CALLBACK_URL = "http://storygram.herokuapp.com/login"
    CLIENT_ID = "79ed614dced54e56a637d45e27411318"
    CLIENT_SECRET = "ee35740c6a1a45999a45515fd7b76ef3"
  else
    #no values for test!
    CALLBACK_URL = ""
    CLIENT_ID = ""
    CLIENT_SECRET = ""
  end

  Instagram.configure do |config|
    config.client_id = CLIENT_ID
    config.client_secret = CLIENT_SECRET
  end
  


  def index
    # copied the code for popular below temporarily
    client = Instagram.client
		@media = client.media_popular
		#render :json => all_media
		
		# determine middle date of media data time events		
	  ugly_start_date = nil
    ugly_end_date = nil
  
    # loop to determine start and end dates for media object  
    @media.each do |media|
      if ugly_start_date.nil? or (media.created_time < ugly_start_date and !media.created_time.nil?)
        ugly_start_date = media.created_time
      end
      if ugly_end_date.nil? or (media.created_time >ugly_end_date and !media.created_time.nil?)
        ugly_end_date = media.created_time
      end
    end

        if ugly_start_date.nil?
          ugly_start_date = 0
        end
        if ugly_end_date.nil?
          ugly_end_date = 0
        end

    @start_date =Integer(ugly_start_date)
    @end_date = Integer(ugly_end_date)
    @middle_date = (Integer(ugly_start_date) + Integer(ugly_end_date )) / 2	
	
	diff = Integer(ugly_end_date) - Integer(ugly_start_date)
	if diff >= 30
		@time_unit
	end
	if diff < 30 && diff >= 7
		@time_unit
	end
	if diff < 7
		@time_unit
	end
		
 
  end

  def popular
		client = Instagram.client
		@media = client.media_popular
		#render :json => all_media
		
		# determine middle date of media data time event
		ugly_start_date = nil
    ugly_end_date = nil
    
    # loop to determine start and end dates for media object
    @media.each do |media|
      if ugly_start_date.nil? or (media.created_time < ugly_start_date and !media.created_time.nil?)
        ugly_start_date = media.created_time
      end
      if ugly_end_date.nil? or (media.created_time >ugly_end_date and !media.created_time.nil?)
        ugly_end_date = media.created_time
      end
    end

        if ugly_start_date.nil?
          ugly_start_date = 0
        end
        if ugly_end_date.nil?
          ugly_end_date = 0
        end

    @start_date =Integer(ugly_start_date)
    @end_date = Integer(ugly_end_date)
    @middle_date = (Integer(ugly_start_date) + Integer(ugly_end_date )) / 2
  
  end

  def login
    if (params[:code])
        response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
        session[:access_token] = response.access_token

        #TODO - for now, authentication redirects you to your own page (even if you were trying to see someone else's)
        redirect_to user_path("self")
    else
      redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
    end
  end

  def user
    if (session[:access_token]) #TODO - this should be checking the Instagram.client access_token instead
      client = Instagram.client(:access_token => session[:access_token]) #TODO - shouldn't be resetting this every time...
      if (params[:userid])
        @media = client.user_recent_media(params[:userid], {:count => 1000})

        #TODO - if we aren't authorized to see this user (or bad parameter), need to handle this
      else
        @media = client.user_recent_media("self", {:count => 1000})
        
        
     end
	 
	 ugly_start_date = nil
        ugly_end_date = nil
      
        @media.each do |media|
          if ugly_start_date.nil? or (media.created_time < ugly_start_date and !media.created_time.nil?)
            ugly_start_date = media.created_time
          end
          if ugly_end_date.nil? or (media.created_time >ugly_end_date and !media.created_time.nil?)
            ugly_end_date = media.created_time
          end
        end

        if ugly_start_date.nil?
          ugly_start_date = 0
        end
        if ugly_end_date.nil?
          ugly_end_date = 0
        end

         @start_date =Integer(ugly_start_date)
         @end_date = Integer(ugly_end_date)
         @middle_date = (Integer(ugly_start_date) + Integer(ugly_end_date )) / 2

    else
      redirect_to login_path
    end
    
    
     
  end

  def search
    q = params[:q]
    client = Instagram.client
    @searchparam = q
    @users = client.user_search(q)

    #TODO - These shouldn't need to be set, either we ajax user search or remove media from the template
    
 
  end

  def search_tags
    q = params[:q]
    client = Instagram.client
    @searchparam = q
    result = client.tag_recent_media(q)
    @media = nil
    if !result.nil?
	    @media = result.data
    end

		ugly_start_date = nil
    ugly_end_date = nil

    if !@media.nil?
      @media.each do |media|

      if ugly_start_date.nil? or (media.created_time < ugly_start_date and !media.created_time.nil?)
          ugly_start_date = media.created_time
        end
        if ugly_end_date.nil? or (media.created_time >ugly_end_date and !media.created_time.nil?)
          ugly_end_date = media.created_time
        end
      end
    end
    
    if ugly_start_date.nil?
      ugly_start_date = 0
    end
    if ugly_end_date.nil?
      ugly_end_date = 0
    end

     @start_date =Integer(ugly_start_date)
     @end_date = Integer(ugly_end_date)
     @middle_date = (Integer(ugly_start_date) + Integer(ugly_end_date )) / 2
	
	
  end

end
