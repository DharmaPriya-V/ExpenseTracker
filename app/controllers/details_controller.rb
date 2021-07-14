class DetailsController < ApplicationController
    def index
        detail=Detail.all
        render json: detail
    end
    def show
        @detail=Detail.find(params[:id])
        render 'show'
    end

    def create
        data=json_payload
        user=Expensegroup.find(data[:expensegroup_id])
        if user[:user_id]==data[:user_id].to_i
               detail=user.details.new(data)
                if detail.save
                      invoice_check(detail)
                      render json: detail
                   else
                       render json: {"error": "cant be saved"}
                    end
        else
            render json: "Not authorized"
    end
end

    def destroy
        @emp=User.find(params[:id])
        @expgrpid=@emp.expensegroups.find(params[:expgrpid])
            @exp=Detail.find(params[:expid])
            if @expgrpid[:id]==@exp[:expensegroup_id]
                 @exp.destroy
            else
            render json: "Error"
            end
    end

    def invoice_check(detail)
        val=detail[:invoiceno].to_i
        if val%2!=0
             detail.update(approval: "rejected") 
         end                          
    end
    def update
        @updater=User.find(params[:user_id])
        @det=Detail.find(params[:expid])
        if ((current_user.admin? && current_user.id!=@updater.id) && @det.user_id==params[:user_id].to_i)
            if @det.update(json_payload)
                 ApprovalMailer.with(updater: @updater, det: @det).confirmation.deliver_now
                 send_mail
             else
                render json: @det.errors
             end
            else
                render json: "error"
            end
    end
    
    def send_mail
        expgrpid=@det[:expensegroup_id]
        @expensegroup=Expensegroup.find(expgrpid)
        sel=@expensegroup.details.where(:approval=>"pending")
       if (sel.count==0) && (@expensegroup[:status]=="sent")
               @expensegroup.totalamount=0
               @expensegroup.approvedamount=0
               @expensegroup.details.each do |expense|
                    if expense[:approval]== "accepted"
                        @expensegroup.approvedamount+=expense.amount    
                    end
                    @expensegroup.totalamount+=expense.amount
                    end
                if @expensegroup.save
                    ApprovalMailer.with(updater: @updater, expgrp: @expensegroup).grpmail.deliver_now
                else
                    render json: "Mail cant be sent"
                end
        else
                render json: "Finish approval"
        end
     end

    end


    
    
