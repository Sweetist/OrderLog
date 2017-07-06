module Api
  class Api::BaseController < ApplicationController
  	#skip_before_action :verify_authenticity_token, :raise => false
  	skip_before_action :authenicate_user!, :raise => false
  	
    protect_from_forgery with: :null_session

  end
end