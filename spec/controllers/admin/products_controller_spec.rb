require 'rails_helper'

describe Admin::ProductsController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /admin/products' do
    before do
      create_list(:product, 3)
      sign_in user
      expect_any_instance_of(Admin::ProductPolicy).to receive(:index?).and_return true
    end

    subject { get admin_products_path }

    it 'renders products' do
      subject

      products = Product.with_attached_images.page(1).per(10)
      product_names = products.map(&:name)
      expect(response.body).to include(*product_names)
    end
  end
end
