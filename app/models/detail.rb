class Detail < ApplicationRecord
#belongs_to :user 
belongs_to :expensegroup
has_many :comments, dependent: :destroy
end
