class CommentsController < ApplicationController
    def create
        user=User.find(params[:id])
        data=json_payload
        comment=Comment.new(data)
        expid=Detail.find(data[:detail_id])
        if expid[:user_id]==user[:id] || user.admin?
             if comment.save
               render json: comment
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