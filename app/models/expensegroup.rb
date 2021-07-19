class Expensegroup < ApplicationRecord
    belongs_to :user
    has_many :details, dependent: :destroy
    accepts_nested_attributes_for :details

    enum group_status:
    {
        incomplete: 0,
        completed: 1
    }

    enum status:
    {
        unsent: 0,
        sent: 1
    }
end
