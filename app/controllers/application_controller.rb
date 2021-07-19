require 'net/http'
require 'net/https'
class ApplicationController < ActionController::API
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    private
    def user_not_authorized(exception)
        render json: "not authorized"
    end

    def json_payload
        HashWithIndifferentAccess.new(JSON.parse(request.raw_post))
    end 

    def detect_admin
        @user=User.find(params[:user_id])
        Current.user = @user
        authorize @user, policy_class: UserPolicy
    end 

    def current_user
        current_user = Current.user
    end

end




