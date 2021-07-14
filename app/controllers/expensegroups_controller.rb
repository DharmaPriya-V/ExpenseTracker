class ExpensegroupsController < ApplicationController
    ALLOWED_DATA= %[user_id name].freeze
    MODIFY_DATA= %[status].freeze
     def create
        data = json_payload.select { |k| ALLOWED_DATA.include? k}
       employeeid=data[:user_id]
       if (User.find(employeeid).status)=="active"
           @expgrp= User.find(employeeid).expensegroups.new(data)
              if @expgrp.save 
                   render json: @expgrp
              else
                    render json: "Error"
              end
            end


end
def show
    @user=User.find(params[:id])
    @expid=Expensegroup.find(params[:expid])
    if (@expid[:user_id].to_i)==(@user[:id].to_i)
          render 'show'
    else
        render json: "Not authorized"
    end    

end
def index
    @exp=Expensegroup.all
    render json:@exp
end
def destroy
    emp=User.find(params[:id])
    expgrp=emp.expensegroups.find(params[:expgrpid])
    if expgrp.destroy 
    render json:"Deleted"
    else
    render json: "Cant be deleted"
    end
end

def status_modify
    @emp=User.find(params[:id])
    @expgrp=@emp.expensegroups.find(params[:expgrpid])
    data = json_payload.select { |k| MODIFY_DATA.include? k}
     if @expgrp.details.count!=0
           @expgrp.update(data)
     else
        render json: "NO expense added to send"
     end
    end
end