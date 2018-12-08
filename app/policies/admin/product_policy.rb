module Admin
  class ProductPolicy < ApplicationPolicy
    def index?
      user.admin? || user.owner?
    end

    def show?
      index?
    end

    def create?
      index?
    end

    def new?
      index?
    end

    def update?
      index?
    end

    def edit?
      index?
    end
  end
end
