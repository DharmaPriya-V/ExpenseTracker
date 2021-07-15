class CommentsController < ApplicationController
  ALLOWED_DATA= %[detail_id description parent_id].freeze
    def create
      data = json_payload.select { |k| ALLOWED_DATA.include? k}
      @user=User.find(params[:aid])
        @emp=User.find(params[:id])
         @expgrp=@emp.expensegroups.find(params[:expgrpid])
         @expid=@expgrp.details.find(data[:detail_id])
        if @user[:id]==@emp[:id]
          render json:"Both admin and employee cant be same"
        else   
          if (@expgrp.status=="sent" && (@expid[:invoiceno].to_i)%2==0)
                @comment=@expid.comments.new(data)  
                if @user.admin? && @comment.save
                ApprovalMailer.with(comment: @comment, expid: @expid).section.deliver_now
                render json: "Mail sent"
                else
                render json: "error"
                 end
        end
      end     
    end
    def show
       # @expid=Comment.find(params[:id])
      # render 'show'
       @user=Comment.all
      render json: @user
    end

    def reply
         data = json_payload.select { |k| ALLOWED_DATA.include? k}
         @emp=User.find(params[:id])
         @expgrp=@emp.expensegroups.find(params[:expgrpid])
         @expid=@expgrp.details.find(data[:detail_id])
         @comment=@expid.comments.new(data)
         if @comment.save
           render 'reply'
  end
end
  def destroy_admin
    @user=User.find(params[:id])
    if @user.admin?
        @emp=User.find(params[:eid])
        @expgrp=@emp.expensegroups.find(params[:expgrpid])
        @expid=@expgrp.details.find(params[:detail_id])
        @cmid=@expid.comments.find(params[:cid])
        if @user.id==@emp.id
              render json: "Both admin and employee cant be same"
        else
        if (@cmid[:parent_id].to_i)==0
              Comment.where(:parent_id=>params[:cid]).delete_all
              @cmid.destroy
        else
          render json: "User comment"
        end
      end
  else
  render json: "Not authorized"
end
end
def destroy_employee
  @emp=User.find(params[:id])
  @expgrp=@emp.expensegroups.find(params[:expgrpid])
  @expid=@expgrp.details.find(params[:detail_id])
  @cmid=@expid.comments.find(params[:cid])
  if @cmid[:parent_id]!=nil
        @cmid.destroy
  else
    render json: "You are not authorized to delete"
  end
end
end