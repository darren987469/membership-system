module Admin
  class UsersController < ApplicationController
    def index
      @users = User.page(1).per(10)
    end
  end
end
