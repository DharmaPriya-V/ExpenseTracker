class Comment < ApplicationRecord
    belongs_to :detail

    def comment_with_user
        expense=Detail.find(detail_id)
        userid=expense[:user_id]
         username=User.find(userid)
         if parent_id.to_i==0
            "#{description} commented by admin"
         else
            "#{description} commented by #{username[:name]} to #{parent_id}"            
    end
end
end
