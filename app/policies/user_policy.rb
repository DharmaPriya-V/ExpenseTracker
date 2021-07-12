class UserPolicy < ApplicationPolicy
  def accept?
    user.admin?
  end
end