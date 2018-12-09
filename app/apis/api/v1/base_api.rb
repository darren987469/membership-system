module API
  module V1
    class BaseAPI < Grape::API
      mount ProductAPI
      mount Admin::UserAPI
    end
  end
end
