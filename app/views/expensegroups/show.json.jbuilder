json.extract! @expid, :name
json.details(@expid.details) do |detail|
    json.allowance detail.allowance
    json.user_id detail.user_id
  json.url detail_url(detail, format: :json)
end    
#json.extract! @expid, :user_id
#json.extract! @user, :id