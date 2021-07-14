class Expensegroup < ApplicationRecord
    belongs_to :user
    has_many :details, dependent: :destroy
end
