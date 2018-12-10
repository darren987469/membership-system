module Helper
  module Pagination
    def paginate(collection, options = {})
      present paginated_object(collection), options
    end

    def paginated_object(collection)
      collection.page(params[:page]).per(params[:per_page])
    end
  end
end
