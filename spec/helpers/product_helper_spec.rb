require 'rails_helper'

describe ProductHelper do
  include described_class

  describe '#product_image_url' do
    let!(:product) { create(:product, images: [fixture_file_upload('spec/fixtures/thumbs-up.png')]) }

    it 'returns url for first image of product' do
      expected = url_for(product.images.first)
      expect(product_image_url(product)).to eq expected
    end
  end
end
