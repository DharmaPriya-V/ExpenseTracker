json.extract! @detail, :allowance, :invoiceno, :user_id, :approval
json.comments(@detail.comments) do |comment|
    json.parent_id comment.parent_id
    json.id comment.id
    json.(comment, :comment_with_user)
end   