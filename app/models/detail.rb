class Detail < ApplicationRecord
    belongs_to :user 
    belongs_to :expensegroup, optional: true
    has_many :comments, dependent: :destroy

    enum approval:
    {
        pending: 0,
        accepted: 1,
        rejected: 2
    }
end

