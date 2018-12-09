module Entity
  module V1
    class Product < Grape::Entity
      expose :id
      expose :name
      expose :price
      expose :discount_amount
      expose :images, using: Entity::V1::Attachment

      def user
        options[:user] || (raise ArgumentError, 'options[:user] is required')
      end

      def discount_ratio
        user.discount_percent.to_f / 100
      end

      def discount_amount
        (object.price * discount_ratio).to_i
      end
    end
  end
end
