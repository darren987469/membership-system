module Helper
  module Pagination
    def self.paginated_entity_class(entity_class)
      Class.new(Grape::Entity) do
        present_collection true, :collection
        expose :collection, as: :results, using: entity_class, documentation: { desc: 'Paginated results.' }
        expose :page, documentation: { type: Integer, desc: 'Current page.' }
        expose :per_page, documentation: { type: Integer, desc: 'Number of results returned in one page.' }
        expose :total_count, documentation: { type: Integer, desc: 'Total number of results.' }

        def page
          object[:collection].current_page
        end

        def per_page
          object[:collection].limit_value
        end

        def total_count
          object[:collection].total_count
        end
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
