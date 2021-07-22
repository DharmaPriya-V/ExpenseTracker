require 'net/http'
require 'net/https'
class ApplicationController < ActionController::API
    include Pundit
    include CustomErrors
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found


    private
    def user_not_authorized(exception)
        render json: "{error: Not authorized}", status: :unauthorized
    end

    def user_not_found(exception)
        render json: "{error: Not found}",  status: :not_found
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




