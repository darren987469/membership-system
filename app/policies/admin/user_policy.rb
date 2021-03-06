module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin? || user.owner?
    end

    def promote_admin?
      user.owner?
    end
  end
end
