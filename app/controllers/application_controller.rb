class ApplicationController < ActionController::API
    #before_action :current_user
    #respond_to :json
    include Pundit
    def json_payload
        HashWithIndifferentAccess.new(JSON.parse(request.raw_post))
    end
    def current_user
    @user=User.find(params[:id])
    return @user
    end

end
