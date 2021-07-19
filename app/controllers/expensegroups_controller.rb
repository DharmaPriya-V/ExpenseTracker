class ExpensegroupsController < ApplicationController
    include Invoice
    before_action :find_user, only: [:create, :show, :index, :destroy, :update]

    def create
        if @user.status=="active"
            @expgrp= @user.expensegroups.new(user_params)
            @expgrp.details.each do |detail|
                detail.update(user_id: @expgrp.user_id)
                detail.save
            end   
            if @expgrp.save 
                render json: @expgrp
            else
                render json: "not saved"
            end
        else
            render json: "User is terminated"
        end
    end

    def show
        @expid=@user.expensegroups.find(params[:id])
        render 'show'
    end    

    def index
        render json: @user.expensegroups
    end

    def destroy
        expgrp=@user.expensegroups.find(params[:id])
        if expgrp.destroy 
            render json:"Deleted"
        else
            render json: "Cant be deleted"
        end
    end

    def update
        expgrp=@user.expensegroups.find(params[:id])
        if(expgrp.unsent? && expgrp.details.count!=0)
            expgrp.update(update_params)
            render json: "updated"
            expgrp.details.each do |detail|
            invoice_check(detail)
            end
        else
            render json: "NO expense added to send or it is already sent"
        end
    end
     
    private
    def user_params
        params.require(:expensegroup).permit(:name, 
        details_attributes: [:allowance, :date, :amount, :description, :approval, :invoiceno, :bills])
    end

    def update_params
        params.require(:expensegroup).permit(:status)
    end

    def find_user
        @user=User.find(params[:user_id])
        Current.user = @user
    end
end
