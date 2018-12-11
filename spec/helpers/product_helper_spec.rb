require 'rails_helper'

describe ProductHelper do
  include described_class

  describe '#product_image(product, resize: nil)' do
    let!(:product) { create(:product, images: images) }

    context 'product has image' do
      let(:images) { [] }

      it { expect(product_image(product)).to be_nil }
    end

    context 'product has no image' do
      let(:images) { [fixture_file_upload('spec/fixtures/thumbs-up.png')] }

      it 'returns resized image variant of the product' do
        expect(product_image(product)).to be_a ActiveStorage::Variant
      end
    end
  end
end
