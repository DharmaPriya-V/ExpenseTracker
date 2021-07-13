class CommentsController < ApplicationController
    def create
        @emp=User.find(params[:id])
        data=json_payload
        @comment=Comment.new(data)
        @expid=Detail.find(data[:detail_id])
        if @expid[:user_id]==@emp[:id] || @emp.admin?
             if @comment.save && @emp.admin
                ApprovalMailer.with(comment: @comment, expid: @expid).section.deliver_now
              else
                render json: "error"
              end
            else
                render json: "Not authorized"
        end
            
    end
    def show
        @expid=Comment.find(params[:id])
       render 'show'
       #@user=Comment.all
       #render json: @user
    end
end