module API
  module V1
    class BaseAPI < Grape::API
      mount Admin::UserAPI
    end
  end
end
