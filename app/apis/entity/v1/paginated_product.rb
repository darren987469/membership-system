module Entity
  module V1
    PaginatedProduct = Helper::Pagination.paginated_entity_class(Entity::V1::Product)
  end
end
