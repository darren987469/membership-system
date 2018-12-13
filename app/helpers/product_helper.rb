module ProductHelper
  def product_default_image(product, resize: product_image_default_size)
    image = product.images.first
    image.nil? ? nil : image.variant(resize: resize)
  end

  def product_image_default_size
    '100x100'
  end
end
