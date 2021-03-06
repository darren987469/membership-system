module UserHelper
  def upgrade_to_premium_button
    return nil unless current_user.normal?

    button_class = 'w3-button w3-section w3-teal w3-ripple'
    button_to('Upgrade to premium', upgrade_to_premium_path, method: :patch, class: button_class)
  end
end
