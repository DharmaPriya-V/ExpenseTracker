class Comment < ApplicationRecord
    belongs_to :detail

    def comment_with_user
        expense=Detail.find(detail_id)
        userid=expense[:user_id]
         username=User.find(userid)
        "#{description}                  commented by #{username.name}"
    end
end
