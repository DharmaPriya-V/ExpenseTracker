class CommentsController < ApplicationController
  before_action :set_detail_for_user, only: [:index, :reply_comment ,:destroy,:destroy_admin]
  before_action :set_detail_for_admin, only: [:create]
  before_action :detect_admin, only: [:create]

  def create
      expgrp=@expense.expensegroup_id
      if @user[:id]==@emp[:id]
          render json:"Both admin and employee cant be same"
      else   
          if((expgrp==nil || Expensegroup.find(expgrp).sent? ) && @expense.system_check_status==true)
              comment=@expense.comments.new(user_params)  
              comment.user_id=@user.id
              if comment.save
                  ApprovalMailer.with(comment: comment, expid: @expense).section.deliver_now
                  render json: "Mail sent"
              else
                  render json: "error"
              end
          else
              render json: "Expense not sent"
          end
      end     
  end

  def index
      @user=Comment.all
      render json: @user
  end

  def reply_comment
      pid=params[:comment_id]
      @comment=@expense.comments.new(user_params)
      @comment.parent_id=pid
      if params[:admin_id]!=nil
          admin_check=User.find(params[:admin_id])
          if admin_check.admin?
              @comment.user_id=params[:admin_id]
              ApprovalMailer.with(comment: @comment, expid: @expense).section.deliver_now
          else 
              render json: "Not an admin"
          end
      else
          @comment.user_id=@expense.user_id
          render 'create_user'
      end  
      @comment.save
  end  

  def destroy_admin
      @user=User.find(params[:eid])
      Current.user=@user
      authorize @user, :accept?
      @cmid=@expense.comments.find(params[:comment_id])
      if @user.id==@emp.id
          render json: "Both admin and employee cant be same"
      else
          if (@cmid.user_id==@user.id || !(User.find(@cmid.user_id).admin?))
              @cmid.destroy
          else
              render json: "You cant destroy"
          end
      end
  end
   
  def destroy
      @cmid=@expense.comments.find(params[:id])
      if @cmid.user_id==@emp.id
          @cmid.destroy
          render json: "deleted"
      else
          render json: "you can't delete"
      end
  end

  private

  def user_params
      params.permit(:description)
  end

  def set_detail_for_user
      @emp=User.find(params[:user_id])
      @expense=@emp.details.find(params[:detail_id])
  end

  def set_detail_for_admin
      @emp=User.find(params[:eid])
      @expense=@emp.details.find(params[:detail_id])
  end
end


