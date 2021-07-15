class UsersController < ApplicationController
    ALLOWED_DATA= %[email phoneno gender name].freeze
    TERMINATE_DATA= %[status].freeze
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
                render json: {"error": "Please ensure you entered correct details"}
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

def update
    userid=User.find(params[:id])
        data = json_payload.select { |k| ALLOWED_DATA.include? k}
        if userid.update(data)
        render json: :"Updated successfully #{userid}"
        else
            render json: "Cant be updated"
        end
    end 

    def terminate
        @user=User.find(params[:id])
        emp=User.find(params[:eid])
        authorize @user, :accept?
        data = json_payload.select { |k| TERMINATE_DATA.include? k}
        if @user.id==emp.id
            render json: "U cant terminate your own account"
        else
          if emp.update(data)
            render json: "Terminated"
          else
            render json: "Cant be terminated"
          end
         end
        end


    def show
        @user=User.find(params[:id])
        render 'show', formats: [:json], handlers: [:jbuilder], status: 200
    end

end


