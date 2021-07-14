json.extract! user, :email, :department, :phoneno, :gender
json.expensegroup(user.expensegroups) do |expensegroup|
    json.name expensegroup.name
  # json.url expensegroup_url(expensegroup, format: :json)
end    