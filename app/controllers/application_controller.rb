class ApplicationController < ActionController::API
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


    #protect_from_forgery with: :exception
    before_action :authenticate_user!

    def user_not_authorized
        render json:{message:"You are not authorized to perform this action."},status: 401
      end

end

