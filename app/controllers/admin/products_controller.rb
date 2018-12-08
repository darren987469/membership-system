module Admin
  class ProductsController < ApplicationController
    before_action :authorize_action

    def index
      @products = Product.with_attached_images.page(1).per(10)
    end

    private

    def authorize_action
      policy_action = "#{action_name}?"
      authorize Product, policy_action, policy_class: Admin::ProductPolicy
    end
  end
end
