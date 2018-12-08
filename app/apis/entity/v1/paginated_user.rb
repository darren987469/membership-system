module Entity
  module V1
    PaginatedUser = Helper::Pagination.paginated_entity_class(Entity::V1::User)
  end
end
