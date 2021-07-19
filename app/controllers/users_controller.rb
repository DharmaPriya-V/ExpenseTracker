class UsersController < ApplicationController
    ALLOWED_DATA= %[email phoneno gender name].freeze
    before_action :detect_admin, only: [:search, :terminate]

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

    def update
        user=User.find(params[:id])
        data = json_payload.select { |k| ALLOWED_DATA.include? k}
        if user.update(data)
            render json: :"Updated successfully #{userid}"
        else
            render json: "Can't be updated"
        end
    end 

    def terminate
        emp=User.find(params[:empid])
        if @user.id==emp.id
            render json: "U can't terminate your own account"
        else
            if emp.update(user_params)
                render json: "Terminated"
            else
                render json: "Can't be terminated"
            end
        end
    end

    def search
        empid= search_params[:empid]
        if empid 
            @see=User.find_by(empid: "#{empid}")
            if @see
                render 'search', formats: [:json], handlers: [:jbuilder], status: :ok
            else
                render json: "user not found"
            end
        else
             render json: "enter the Employee id to search"
        end
    end

    def show
        @user=User.find(params[:id])
        render 'show', formats: [:json], handlers: [:jbuilder], status: :ok
    end

    private
    def user_params
        params.permit(:status)
    end

    def search_params
        params.permit(:empid)
    end
end

