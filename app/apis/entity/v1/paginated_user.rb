module Entity
  module V1
    PaginatedUser = Entity::V1::Pagination.paginated_entity_class(Entity::V1::User)
  end
end
