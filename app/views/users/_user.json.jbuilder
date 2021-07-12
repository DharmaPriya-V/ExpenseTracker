json.extract! user, :email, :department, :phoneno, :gender
json.details(user.details) do |detail|
    json.invoiceno detail.invoiceno
   json.url detail_url(detail, format: :json)
end    