module Entity
  module V1
    class PaginationLinks < Grape::Entity
      with_options(expose_nil: false) do
        expose :first, documentation: { type: String, desc: 'First page link if exists.' }
        expose :prev, documentation: { type: String, desc: 'Previous page link if exists.' }
        expose :next, documentation: { type: String, desc: 'Next page link if exists.' }
        expose :last, documentation: { type: String, desc: 'Last page link if exists.' }
      end
    end
  end
end
