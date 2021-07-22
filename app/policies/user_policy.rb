class UserPolicy < ApplicationPolicy
  def accept?
    user.admin? && user.status=="active"
  end
  def destroy_admin?
    user.admin? && user.status=="active"
  end
  def current_user?
    user.admin? && user.status=="active"
  end
  def search?
    user.admin? && user.status=="active"
  end
  def terminate?
  user.admin? && user.status=="active"
  end
  def update_detail?
    user.admin? && user.status=="active"
  end
  def create?
    user.admin? && user.status=="active"
  end
  def destroy_admin?
    user.admin? && user.status=="active"
  end
  def reply_comment?
    user.admin? && user.status=="active"
  end
end