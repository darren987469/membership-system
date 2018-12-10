module Helper
  module Pagination
    def self.paginated_entity_class(entity_class)
      Class.new(Grape::Entity) do
        include Kaminari::Helpers::HelperMethods
        include ActionView::Helpers::TranslationHelper

        present_collection true, :collection
        expose :collection, as: :results, using: entity_class, documentation: { desc: 'Paginated results.' }
        expose :page, documentation: { type: Integer, desc: 'Current page.' }
        expose :total_pages, documentation: { type: Integer, desc: 'Number of pages.' }
        expose :per_page, documentation: { type: Integer, desc: 'Number of results returned in one page.' }
        expose :total_count, documentation: { type: Integer, desc: 'Total number of results.' }
        expose :page_info, as: :page_entries_info, documentation: { type: String, desc: 'Renders message with numbers of displayed vs. total entries.' }

        def page
          object[:collection].current_page
        end

        def total_pages
          object[:collection].total_pages
        end

        def per_page
          object[:collection].limit_value
        end

        def total_count
          object[:collection].total_count
        end

        def page_info
          page_entries_info(object[:collection])
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
