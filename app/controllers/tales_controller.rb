class TalesController < ApplicationController
	
	def index
		client = Instagram.client(:access_token => session[:access_token])
		@media = client.user_recent_media("self", {:count => 1000})

		if !params[:story].nil? && !Tale.where(:id => params[:story]).nil?
			if !Tale.find(params[:story]).images.nil?
				@images = Tale.find(params[:story]).images.split(',')
			end
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
		
			
	end
	
	def mystories
		@tale = Tale.new
		render :partial => 'includes/tales'
	end 
	
	def create
    	@tale = Tale.new(params[:tale])
		#flash[:notice] = "You just wrote a new story!"
    	if @tale.save
			respond_to do |format|	
				#format.html { redirect_to :action => 'index' }
				format.js
			end
		else
			
		end
	end
	
	def edit
		@tale = Tale.find(params[:id])
		render :partial => 'includes/form'
	end
	
	def update
    	@tale = Tale.find(params[:id])
		#flash[:notice] = "You just updated a story"
		if @tale.update_attributes(params[:tale])
			respond_to do |format|
				format.js
			end
		end
	end
  	
	def save_story
    	@tale = Tale.find(params[:id])
		@tale.images = params[:images]
		@tale.save
	end
	
	def destroy
		@tale = Tale.find(params[:id])
		@tale.destroy
		#flash[:notice] = "You just deleted a story!"
		render :file => "/tales/index.js"
	end
end
