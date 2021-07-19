class DetailsController < ApplicationController
    include Invoice
    include Mailing
    ALLOWED_DATA=%[allowance date amount description invoiceno bills].freeze
    before_action :set_the_user, only: [:index, :show, :destroy, :update]
    before_action :detect_admin , only: [:update_detail]
    after_action  :send_mail, only: %i[update_detail]
    def index
        render json: @user.details
    end

    def show
        @detail=@user.details.find(params[:id])
        render 'show'
    end

    def create
        user=User.find(params[:user_id])
        if user.status=="active"
            if params[:expensegroup_id]==nil
                detail=user.details.new(detail_params)         
                if detail.save                  
                    invoice_check(detail)
                    render json: detail
                else
                    render json: {"error": "cant be saved"}
                end
            else
                expgrp=Expensegroup.find(params[:expensegroup_id])
                if expgrp.sent?
                    render json: "Already sent you cant update"
                else
                    detail=expgrp.details.new(detail_params)
                    detail.update(user_id: expgrp.user_id)
                    if detail.save
                        render json: detail
                    else
                        render json: "Cant be saved"    
                    end      
                end      
            end
        end
    end

    def destroy
        @exp=@user.details.find(params[:id])
        if  @exp.destroy
            render json: "Deleted"
        else
            render json: "Error"
        end
    end
   
    def update_detail
        employee=User.find(params[:eid])
        expense=employee.details.find(params[:detail_id])
        if expense.expensegroup_id!=nil
            expgrp=Expensegroup.find(expense.expensegroup_id)
            if ((@user.id!=employee.id) && expense.pending? && expgrp.sent?)
                if expense.update(update_params)
                    ApprovalMailer.with(updater: employee, det: expense).confirmation.deliver_now
                    render json: "Mail sent"
                end
            else
                render json: "cant be sent"
            end
        else
            if expense.pending?
                expense.update(update_params)    
                ApprovalMailer.with(updater: employee, det: expense).confirmation.deliver_now 
            else
                render json: "Expense not sent"
            end    
        end
    end    
   
    def update
        exp=@user.details.find(params[:id])
        if exp.expensegroup_id!=nil
            expgrp=Expensegroup.find(exp.expensegroup_id)  
            if expgrp.sent?
                render json: "Already sent you cant update"
            else
                data = json_payload.select { |k| ALLOWED_DATA.include? k}
                exp.update(data)
                render json: "Updated sucessfully"
            end
        else
            render json: "already sent"
        end
    end
    
    private
    def update_params
        params.permit(:approval)
    end

    def detail_params
        params.permit(:allowance , :date, :amount , :invoiceno, :description, :approval ,:bills)
    end

    def set_the_user
        @user=User.find(params[:user_id])
        Current.user= @user
    end 
end





    
    
