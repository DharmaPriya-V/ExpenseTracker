class DetailsController < ApplicationController
    def index
        detail=Detail.all
        render json: detail
    end
    def show
        @detail=Detail.find(params[:id])
        render 'show'
    end

    def create
        data=json_payload
        detail=Detail.new(data)
            if invoice_check(detail) || true
                if detail.save
                  render json: detail
                   else
                render json: {"error": "cant be saved"}
                end
            end
    end

    def destroy
        @detail=Detail.find(params[:eid])
        user_id=@detail[:user_id]
        if user_id==current_user[:id]
            @detail.destroy
        else
            render json: {"error": "not created"}
        end
    end

    def invoice_check(detail)
        val=detail[:invoiceno].to_i
        if val%2!=0
            detail[:approval]="rejected" 
         end                          
    end

    def update
        @det=Detail.find(params[:id])
        @user=User.find(@det[:user_id])
            if @det.update(detail_params)
                 ApprovalMailer.with(user: @user, det: @det).confirmation.deliver_now
                 render json: @det
             else
                render json: @det.errors
             end
    end

        def detail_params
           params.require(:detail).permit(:approval)
        end           
end
