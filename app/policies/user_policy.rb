class UserPolicy < ApplicationPolicy
  def upgrade_to_premium?
    user.normal?
  end
end
