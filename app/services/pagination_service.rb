class PaginationService
  attr_reader :collection

  def initialize(collection)
    @collection = collection
  end

  def pages
    @pages ||= begin
      return {} if collection.out_of_range?

      {}.tap do |pages|
        unless collection.first_page?
          pages[:first] = 1
          pages[:prev] = collection.current_page - 1
        end

        unless collection.last_page?
          pages[:last] = collection.total_pages
          pages[:next] = collection.current_page + 1
        end
      end
    end
  end

  def links(request)
    @links ||= begin
      url = request.url.sub(/\?.*$/, '')
      old_params = Rack::Utils.parse_nested_query(request.query_string)

      {}.tap do |links|
        pages.each do |key, value|
          new_params = old_params.merge('page' => value)
          links[key] = %(#{url}?#{new_params.to_param})
        end
      end
    end
  end
end
