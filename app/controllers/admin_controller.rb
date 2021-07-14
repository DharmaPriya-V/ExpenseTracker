class AdminController < ApplicationController
    ALLOWED_DATA= %[empid].freeze
     def search
        data = json_payload.select { |k| ALLOWED_DATA.include? k}
        @user=User.find(params[:id])
        empid= data[:empid]
        if empid && (authorize @user, :accept?)
            @see=User.find_by(empid: "#{empid}")
               if @see
                render 'search', formats: [:json], handlers: [:jbuilder], status: 200
               else
                render json: "user not found"
               end
            else
                render json: "enter the Employee id to search"
            end
       
        end
    end