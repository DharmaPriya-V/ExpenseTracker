json.extract! see, :email, :department, :phoneno, :gender
json.expensegroups(see.expensegroups.where(status: "sent", grp_status: nil)) do |expensegroup|
    json.name expensegroup.name
    json.id expensegroup.id
    json.expenses(expensegroup.details.where(approval: "pending")) do |detail|
    json.allowance detail.allowance
    json.invoiceno detail.invoiceno
    json.url detail_url(detail, format: :json)
end   
end