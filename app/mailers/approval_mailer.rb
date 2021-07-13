class ApprovalMailer < ApplicationMailer
    default from: "priya@gmail.com"
    def confirmation
        @token=params[:user].signed_id
        @user=params[:user]
        @det=params[:det]
        mail(to: @user.email, from: "priyacred3@gmail.com", subject: "Expense", message: @det.approval)

    end
    def section
        @comment=params[:comment]
        @expid=params[:expid]
        @username=User.find(@expid[:user_id])
        mail(to: @username.email, from: "priyacred3@gmail.com", subject: "Comment on ur Expense")
    end
end
