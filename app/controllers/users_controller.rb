class UsersController < ApplicationController
  def upgrade_to_premium
    authorize User, :upgrade_to_premium?

    current_user.update(role: :premium)

    redirect_to products_path
  end
end
