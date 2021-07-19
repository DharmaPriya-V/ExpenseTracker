json.extract! @expid, :name
json.details(@expid.details) do |detail|
  json.id detail.id
    json.allowance detail.allowance
    json.invoiceno detail.invoiceno
    json.system_check_status detail.system_check_status
 # json.url  user_expensegroup_detail_url(detail, format: :json)
end    
#json.extract! @expid, :user_id
#json.extract! @user, :id