require 'rails_helper'

describe Entity::V1::Attachment do
  include Rails.application.routes.url_helpers

  let(:image) { fixture_file_upload('spec/fixtures/thumbs-up.png') }
  let!(:product) { create(:product, images: [image]) }
  let(:attachment) { product.images.first }
  let(:entity) { described_class.new(attachment) }

  subject { entity.as_json }

  it { expect(subject[:url]).to eq url_for(attachment) }
end
