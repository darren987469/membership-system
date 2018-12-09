require 'rails_helper'

describe Entity::V1::Product do
  let(:image) { fixture_file_upload('spec/fixtures/thumbs-up.png') }
  let!(:product) { create(:product, images: [image]) }
  let(:entity) { described_class.new(product) }

  subject { entity.as_json }

  it { expect(subject[:id]).to eq product.id }
  it { expect(subject[:name]).to eq product.name }
  it { expect(subject[:price]).to eq product.price }

  describe '#images' do
    it 'returns image urls' do
      expected = Entity::V1::Attachment.represent(product.images.to_a).as_json
      expect(subject[:images]).to eq expected
    end
  end
end
