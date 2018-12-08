module Helper
  module Base
    def authenticate_user!
      current_user || (raise NotAuthenticatedError)
    end

    def current_user
      devise_user
    end
  end
end
