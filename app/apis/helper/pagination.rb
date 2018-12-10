module Helper
  module Pagination
    def self.paginated_entity_class(entity_class)
      Class.new(Entity::V1::Pagination) do
        present_collection true, :collection
        expose :collection, as: :results, using: entity_class, documentation: { desc: 'Paginated results.' }
      end
    end

    def paginate(collection, options = {})
      present paginated_object(collection), options
    end

    def paginated_object(collection)
      collection.page(params[:page]).per(params[:per_page])
    end
  end
end
