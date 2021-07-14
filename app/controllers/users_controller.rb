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
            user.status="active"
            if user.save
                render json: user
              else
                render json: {"error": "Please ensure you entered correct email Address and Password"}
               end
        end
    end

    def destroy
        @user=User.find(params[:id])
        @del=User.find(params[:empid])
         authorize @user, :accept?
         if @user.id==@del.id
            render json: "U cant delete your own account"
         else
            @del.destroy
         end
        
end

    def show
        @user=User.find(params[:id])
        render 'show', formats: [:json], handlers: [:jbuilder], status: 200
    end

end


