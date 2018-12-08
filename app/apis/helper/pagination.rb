module Helper
  module Pagination
    def self.paginated_entity_class(entity_class)
      Class.new(Grape::Entity) do
        expose :collection, as: :results, using: entity_class, documentation: { desc: 'Paginated results.' }
        expose :links, using: Entity::V1::PaginationLinks, documentation: { desc: 'Links for traversing with pagination.' }
        expose :page, documentation: { type: Integer, desc: 'Current page.' }
        expose :per_page, documentation: { type: Integer, desc: 'Number of results returned in one page.' }

        def collection
          object.collection
        end

        def page
          collection.current_page
        end

        def per_page
          collection.limit_value
        end
      end
    end

    def paginate(collection, options = {})
      present paginated_object(collection), options
    end

    def paginated_object(collection)
      collection = collection.page(params[:page]).per(params[:per_page])
      links = PaginationService.new(collection).links(request)

      OpenStruct.new(
        collection: collection,
        links: OpenStruct.new(links)
      )
    end
  end
end
