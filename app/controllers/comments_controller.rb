class CommentsController < ApplicationController
  before_action :set_detail_for_user, only: [:index, :reply_comment ,:destroy,:destroy_admin]
  before_action :set_detail_for_admin, only: [:create]
  before_action :detect_admin, only: [:create]

  def create
      expgrp=@expense.expensegroup_id
      if @user[:id]==@emp[:id]
          render json:"{error: Both admin and employee cant be same}", status: :bad_request
      else   
          if((expgrp==nil || Expensegroup.find(expgrp).sent? ) && @expense.system_check_status==true)
              comment=@expense.comments.new(user_params)  
              comment.user_id=@user.id
              if comment.save
                  ApprovalMailer.with(comment: comment, expid: @expense).section.deliver_now
                  render json: "{message: Mail sent}", status: :created
              end
          else
              render json: "{error: Expense not sent}", status: :bad_request
          end
      end     
  end

  def index
      @user=Comment.all
      render json: @user, status: :ok
  end

  def reply_comment
      pid=params[:comment_id]
      @comment=@expense.comments.new(user_params)
      @comment.parent_id=pid
      if params[:admin_id]!=nil 
          @admin=User.find(params[:admin_id])
          Current.user=@admin
          authorize @admin, policy_class: UserPolicy
          @comment.user_id=params[:admin_id]
          ApprovalMailer.with(comment: @comment, expid: @expense).section.deliver_now
      else
          @comment.user_id=@expense.user_id
      end  
      @comment.save
      render 'reply_comment', status: :created
  end  

  def destroy_admin
      @user=User.find(params[:eid])
      Current.user=@user
      authorize @user, :accept?
      @cmid=@expense.comments.find(params[:comment_id])
      if @user.id==@emp.id
          render json: "{error: Both admin and employee cant be same}", status: :bad_request
      else
          if (@cmid.user_id==@user.id || !(User.find(@cmid.user_id).admin?))
              @cmid.destroy
              render json: "{message: Deleted}", status: :ok
          else
              render json: "{error: You can't destroy}", status: :unauthorized
          end
      end
  end
   
  def destroy
      @cmid=@expense.comments.find(params[:id])
      if @cmid.user_id==@emp.id
          @cmid.destroy
          render json: "{error: deleted}", status: :ok
      else
          render json: "{error: you can't delete}", status: :unauthorized
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


