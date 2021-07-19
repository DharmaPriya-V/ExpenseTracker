json.extract! @see, :email, :department, :phone_no, :gender
json.expensegroups(@see.expensegroups.incomplete.sent) do |expensegroup|
    json.name expensegroup.name
    json.id expensegroup.id
    json.expenses(expensegroup.details.pending.where(system_check_status: true)) do |detail|
    json.id detail.id
    json.system_check_status detail.system_check_status
    json.allowance detail.allowance
    json.invoiceno detail.invoiceno
    json.approval detail.approval
    end   
end

json.expenses(@see.details.pending.where(expensegroup_id: nil, system_check_status: true)) do |detail|
    json.id detail.id
    json.user_id detail.user_id
    json.expnesegroup_id detail.expensegroup_id
    json.allowance detail.allowance
    json.invoiceno detail.invoiceno
    json.approval detail.approval
    json.system_check_status detail.system_check_status
end    

