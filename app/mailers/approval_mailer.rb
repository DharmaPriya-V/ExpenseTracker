class ApprovalMailer < ApplicationMailer
    default from: "priya@gmail.com"
    def confirmation
        @token=params[:user].signed_id
        @user=params[:user]
        @det=params[:det]
        mail(to: "dharmapriya333@gmail.com", from: "priyacred3@gmail.com", subject: "Expense", message: @det.approval)

end
end
