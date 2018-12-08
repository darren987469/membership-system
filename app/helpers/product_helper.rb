module ProductHelper
  def product_image_url(product)
    image = product.images.first
    url_for(image)
  end

  def product_image_default_size
    '150x100'
  end
end
