class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!

  rescue_from Pundit::NotAuthorizedError do |_error|
    render file: 'public/403.html'
  end
end
