module API
  module V1
    class ProductAPI < Grape::API
      helpers Helper::SharedParams

      resource :products do
        before { authenticate_user! }

        desc 'Get products'
        params do
          use :pagination
        end
        get do
          products = Product.with_attached_images

          paginate products, with: Entity::V1::PaginatedProduct, user: current_user
        end
      end
    end
  end
end
