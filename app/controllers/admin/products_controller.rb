module Admin
  class ProductsController < Admin::BaseController
    before_action :authorize_action
    before_action :set_product, only: %i[show edit update destroy destroy_image]

    def index
      @products = Product.order(id: :asc).with_attached_images.page(page).per(per)
    end

    def show; end

    def create
      @product = Product.create(product_params)
      redirect_to admin_product_path(@product)
    end

    def new
      @product = Product.new
    end

    def update
      @product.update(product_params)
      redirect_to admin_product_path(@product)
    end

    def edit; end

    def destroy_image
      @image = @product.images.find(params[:image_id])
      @image.purge
      redirect_to admin_product_path(@product)
    end

    private

    def authorize_action
      policy_action = "#{action_name}?"
      authorize Product, policy_action, policy_class: Admin::ProductPolicy
    end

    def set_product
      @product = @product = Product.find(params[:id])
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
