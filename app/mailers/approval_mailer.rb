class ApprovalMailer < ApplicationMailer
    default from: "priya@gmail.com"
    def confirmation
        @updater=params[:updater]
        @det=params[:det]
        mail(to: @updater.email, from: "priyacred3@gmail.com", subject: "Expense", message: @det.approval)

    end
    def section
        @comment=params[:comment]
        @expid=params[:expid]
        @username=User.find(@expid[:user_id])
        mail(to: @username.email , from: "priyacred3@gmail.com", subject: "Comment on ur Expense")
    end
    def grpmail
        @up=params[:updater]
        @ex=params[:expgrp]
        mail(to: @up.email, from: "priyacred3@gmail.com", subject: "Expense group")
end
end
