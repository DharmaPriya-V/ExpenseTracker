json.extract! @detail, :allowance, :invoiceno, :user_id, :approval
json.details(@detail.comments) do |comment|
    json.(comment, :comment_with_user)
end   