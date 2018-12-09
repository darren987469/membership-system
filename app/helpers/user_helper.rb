module UserHelper
  def upgrade_to_premium_button
    return nil unless current_user.normal?

    button_to('Upgrade to premium', upgrade_to_premium_path, method: :patch)
  end
end
