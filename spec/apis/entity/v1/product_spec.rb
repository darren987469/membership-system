require 'rails_helper'

describe Entity::V1::Product do
  let(:user) { create(:user, role: :premium) }
  let(:image) { fixture_file_upload('spec/fixtures/thumbs-up.png') }
  let(:price) { 99 }
  let!(:product) { create(:product, price: price, images: [image]) }
  let(:entity) { described_class.new(product, user: user) }

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

  describe '#user' do
    context 'user given in options' do
      it { expect(entity.user).to eq user }
    end

    context 'without user given in options' do
      let(:entity) { described_class.new(product) }

      it 'raise ArgumentError' do
        expect { entity.user }.to raise_error(ArgumentError, 'options[:user] is required')
      end
    end
  end

  # discount_amount = price * discount_ratio
  describe '#discount_amount' do
    context 'when decimal count' do
      it 'rounds down the amount' do
        expect(product.price).to eq 99
        expect(entity.discount_ratio).to eq 0.1
        expect(entity.discount_amount).to eq 9
      end
    end

    context 'without decimal count' do
      let(:price) { 100 }

      it 'returns amount calculated' do
        expect(product.price).to eq 100
        expect(entity.discount_ratio).to eq 0.1
        expect(entity.discount_amount).to eq 10
      end
    end
  end
end
