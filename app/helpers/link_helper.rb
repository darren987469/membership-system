module LinkHelper
  def link_to_admin
    return nil unless current_user.admin? || current_user.owner?
    return nil if controller.class < Admin::BaseController

    link_to('Go to Admin', admin_products_path, class: 'w3-bar-item w3-button')
  end

  def link_to_website
    return nil if controller.class == ProductsController

    link_to('Go to Website', products_path, class: 'w3-bar-item w3-button')
  end

  def link_to_admin_or_website
    controller.class < Admin::BaseController ? link_to_website : link_to_admin
  end
end
