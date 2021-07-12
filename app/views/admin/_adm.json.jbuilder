json.extract! see, :email, :department, :phoneno, :gender
json.details(see.details.where(approval: "pending")) do |detail|
    json.invoiceno detail.invoiceno
    json.url detail_url(detail, format: :json)
end   