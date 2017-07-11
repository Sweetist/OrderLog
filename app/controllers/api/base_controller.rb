module Api
	class Api::BaseController < ApplicationController

		#before_filter :authenticate_user_from_token!
		protect_from_forgery with: :null_session
	#before_action :authenticate_user!
	#acts_as_token_authentication_handler_for User, fallback: :none
  	# This is our new function that comes before Devise's one
  	#before_action :authenticate_user_from_token!
  	# This is Devise's authentication
  	#before_action :authenticate_user!

  # To make authentication mechanism more safe,
  # require an access_token and a user_email.
  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    # Use Devise.secure_compare to compare the access_token
    # in the database with the access_token given in the params.
    if user && Devise.secure_compare(user.access_token, params[:access_token])

      # Passing store false, will not store the user in the session,
      # so an access_token is needed for every request.
      # If you want the access_token to work as a sign in token,
      # you can simply remove store: false.
      sign_in user, store: false
    end
  end


	end
end