json.extract! user, :email, :department, :phone_no, :gender
json.expensegroup(user.expensegroups) do |expensegroup|
    json.name expensegroup.name
end    
