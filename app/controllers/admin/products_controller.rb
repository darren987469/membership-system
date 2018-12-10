module Admin
  class ProductsController < Admin::BaseController
    before_action :authorize_action

    def index
      @products = Product.order(id: :asc).with_attached_images.page(page).per(per)
    end

    def show
      @product = Product.find(params[:id])
    end

    def create
      @product = Product.create(product_params)
      redirect_to admin_product_path(@product)
    end

    def new
      @product = Product.new
    end

    def update
      @product = Product.find(params[:id])
      @product.update(product_params)
      redirect_to admin_product_path(@product)
    end

    def edit
      @product = Product.find(params[:id])
    end

    private

    def authorize_action
      policy_action = "#{action_name}?"
      authorize Product, policy_action, policy_class: Admin::ProductPolicy
    end

    def product_params
      params.require(:product).permit(:name, :price, images: [])
    end

    def page
      params[:page] || 1
    end

    def per
      params[:per] || 10
    end
  end
end
