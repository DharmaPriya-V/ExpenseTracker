module Mailing
    def send_mail
        expense=Detail.find(params[:detail_id])
        employee=User.find(params[:eid])
        if expense.expensegroup_id!=nil
            expensegroup=Expensegroup.find(expense.expensegroup_id)
            sel=expensegroup.details.pending
            if ((sel.count==0) && (expensegroup.sent?) && !expensegroup.completed?)
            expensegroup.completed!
            expensegroup.totalamount=0
            expensegroup.approvedamount=0
            expensegroup.details.each do |expense|
                if expense.accepted?
                     expensegroup.approvedamount+=expense.amount    
                end
                     expensegroup.totalamount+=expense.amount
                end
                if expensegroup.save
                    ApprovalMailer.with(updater: employee, expgrp: expensegroup).grpmail.deliver_now
                end
            end
        end
    end
end 
  