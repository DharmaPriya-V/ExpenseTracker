class UsersController < ApplicationController
    def index
        user=User.all
        render json: user
    end
    def create
        data=json_payload
        user=User.new(data)
        if User.exists?(:email => "#{user[:email]}")
            render json: {"error": "Already exits"}
        else
            if user.save
                render json: user
              else
                render json: {"error": "Please ensure you entered correct email Address and Password"}
               end
        end
    end

    def destroy
        @user=current_user
        if authorize @user, :accept?
        @user.destroy
    end
end

    def show
        @user=User.find(params[:id])
        render 'show', formats: [:json], handlers: [:jbuilder], status: 200
    end

    def accept
        @user=User.find(params[:id])
        if authorize @user
            render json: "Accepted"
        else
            render json: "not authorized"
        end
    end

end


