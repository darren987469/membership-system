module Entity
  module V1
    class Attachment < Grape::Entity
      include Rails.application.routes.url_helpers

      expose :url

      def url
        url_for(object)
      end
    end
  end
end
