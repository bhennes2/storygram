class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_var

  private
  def set_var
    if Rails.env.production?
      @GOOGLE_API_KEY = "ABQIAAAAIao_pqN15R-rciPTw_IW4RSWUrU5MiNgPolksHXesvz1iqi1gRT2yOTWoCKdI8Rcyp_Cv5PkOaOWNg"
    elsif Rails.env.development?
      @GOOGLE_API_KEY = "ABQIAAAAlwSM1BnxspuGelI1SSwqPhTJQa0g3IQ9GZqIMmInSLzwtGDKaBTWWY9RvvePVzf92g9Ej0ODOUoAmQ"
    else
      #no values for test!
      @GOOGLE_API_KEY = ""
    end
  end
end

class Q < ActiveRecord::Base
	#validates_presence_of :q

end