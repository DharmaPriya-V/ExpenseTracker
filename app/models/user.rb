class User < ApplicationRecord
   has_secure_password
   validates_presence_of :email
   validates :email, format:{with: /[^@\s]+@[^@\s]+/, message: "Must be valid Email Address"}
    has_many :details, dependent: :destroy
end
