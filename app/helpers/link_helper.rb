module LinkHelper
  def link_to_admin
    return nil unless current_user.admin? || current_user.owner?

    link_to('Go to Admin', admin_products_path, class: 'w3-bar-item w3-button')
  end
end
