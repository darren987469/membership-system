module Entity
  module V1
    class Product < Grape::Entity
      expose :id
      expose :name
      expose :price
      expose :images, using: Entity::V1::Attachment
    end
  end
end
