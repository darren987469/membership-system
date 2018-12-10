module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.page(1).per(10)
    end
  end
end
