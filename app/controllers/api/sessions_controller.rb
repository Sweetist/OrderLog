module Api
  class Api::SessionsController < Devise::SessionsController
    def create
      super
      render json: { auth_token: current_user.authorization_token }
    end
  end
end