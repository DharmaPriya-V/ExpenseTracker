class Comment < ApplicationRecord
    belongs_to :detail
    has_many :children, class_name: 'Comment', dependent: :destroy, foreign_key: :parent_id
    belongs_to :parent, class_name: 'Comment', optional: true

    def comment_with_user
        expense=Detail.find(detail_id)
        username=User.find(user_id)
        if parent_id==nil 
            "#{description} commented by admin"
         else
            "#{description} commented by #{username[:name]} to #{parent_id}"            
        end
    end
end

