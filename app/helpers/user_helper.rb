module UserHelper
  def upgrade_to_premium_button
    return nil unless current_user.normal?

    button_to('Upgrade to premium', upgrade_to_premium_path, method: :patch, class: default_button_class)
  end

  def link_to_admin
    return nil unless current_user.admin? || current_user.owner?

    link_to('Go to Admin', admin_products_path, class: 'w3-bar-item w3-button')
  end
end
