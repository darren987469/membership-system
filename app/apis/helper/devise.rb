module Helper
  module Devise
    def warden
      env['warden']
    end

    def devise_user
      warden.user
    end
  end
end
