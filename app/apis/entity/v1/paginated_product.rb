module Entity
  module V1
    PaginatedProduct = Entity::V1::Pagination.paginated_entity_class(Entity::V1::Product)
  end
end
