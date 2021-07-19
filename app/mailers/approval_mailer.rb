class ApprovalMailer < ApplicationMailer
    default from: "priya@gmail.com"
    def confirmation
        @updater=params[:updater]
        @det=params[:det]
        mail(to: @updater.email ,from: "priyacred3@gmail.com", subject: "Expense approval", message: @det.approval)
    end

    def section
        @comment=params[:comment]
        @expid=params[:expid]
        @username=User.find(@expid[:user_id])
        mail(to: @username.email , from: "priyacred3@gmail.com", subject: "Comment on ur Expense")
    end

    def grpmail
        @user_to_update=params[:updater]
        @expensegroup=params[:expgrp]
        mail(to: @user_to_update.email , from: "priyacred3@gmail.com", subject: "Expense group with approved and rejected details")
    end
end
