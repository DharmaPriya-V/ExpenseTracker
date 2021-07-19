class UserPolicy < ApplicationPolicy
  def accept?
    user.admin?
  end
  def destroy_admin?
    user.admin?
  end
  def current_user?
    user.admin?
  end
  def search?
    user.admin?
  end
  def terminate?
  user.admin? && user.status=="active"
  end
  def update_detail?
    user.admin?
  end
  def create?
    user.admin?
  end
  def destroy_admin?
    user.admin?
  end
end