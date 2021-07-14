class UserPolicy < ApplicationPolicy
  def accept?
    user.admin?
  end
  def destroy_admin?
    user.admin?
  end
end