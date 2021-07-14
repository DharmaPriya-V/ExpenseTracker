class CommentsController < ApplicationController
  ALLOWED_DATA= %[detail_id description].freeze
    def create
      data = json_payload.select { |k| ALLOWED_DATA.include? k}
      @user=User.find(params[:aid])
        @emp=User.find(params[:id])
         @expgrp=@emp.expensegroups.find(params[:expgrpid])
         @expid=@expgrp.details.find(data[:detail_id])
        if @user[:id]==@emp[:id]
          render json:"Both admin and employee cant be same"
        else    
                @comment=@expid.comments.new(data)  
                if @comment.save && @user.admin?
                ApprovalMailer.with(comment: @comment, expid: @expid).section.deliver_now
                else
                render json: "error"
                 end
        end
            
    end
    def show
        #@expid=Comment.find(params[:id])
       #render 'show'
       @user=Comment.all
       render json: @user
    end
end