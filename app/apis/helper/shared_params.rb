module Helper
  module SharedParams
    extend Grape::API::Helpers

    params :pagination do |_options|
      optional :per_page, type: Integer, default: 10, values: 1..100, desc: 'Number of results to return.'
      optional :page, type: Integer, default: 1, desc: 'Page of results.'
    end
  end
end
