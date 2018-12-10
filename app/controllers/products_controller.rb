class ProductsController < ApplicationController
  def index
    @products = Product.with_attached_images.page(1).per(12)
  end
end
