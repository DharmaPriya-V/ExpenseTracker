class AdminController < ApplicationController
     def search
        data=json_payload
        @user=User.find(params[:id])
        empid= data[:empid]
        if empid
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