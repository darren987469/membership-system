require 'rails_helper'

describe Admin::ProductsController, type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /admin/products' do
    let(:params) { {} }

    before do
      create_list(:product, 11)
      expect_any_instance_of(Admin::ProductPolicy).to receive(:index?).and_return true
    end

    subject { get admin_products_path, params: params }

    it 'renders products, default page 1 per 10' do
      subject

      products = Product.with_attached_images.page(1).per(10)
      product_names = products.map(&:name)
      expect(response.body).to include(*product_names)
    end

    context 'given page and per in params' do
      let(:params) { { page: 2, per: 3 } }

      it 'renders products with given page and per' do
        subject

        products = Product.with_attached_images.page(params[:page]).per(params[:per])
        product_names = products.map(&:name)
        expect(response.body).to include(*product_names)
      end
    end
  end

  describe 'GET /admin/products/:id' do
    let!(:product) { create(:product) }

    before { expect_any_instance_of(Admin::ProductPolicy).to receive(:show?).and_return true }

    subject { get admin_product_path(product) }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status :success
      expect(response.body).to include product.name
    end
  end

  describe 'POST /admin/products' do
    let(:image) { fixture_file_upload('spec/fixtures/thumbs-up.png') }
    let(:params) do
      {
        product: { name: 'name', price: 10, images: [image] }
      }
    end
    before { expect_any_instance_of(Admin::ProductPolicy).to receive(:create?).and_return true }

    subject { post admin_products_path, params: params }

    it 'creates product' do
      expect { subject }.to change { Product.count }.by(1)

      product = Product.last
      expected_attributes = params[:product].except(:images)
      expect(product).to have_attributes(expected_attributes)

      expected_image_names = [image.original_filename]
      image_names = product.images.map { |record| record.filename.to_s }
      expect(image_names).to match_array expected_image_names
    end

    it { is_expected.to redirect_to admin_product_path(Product.last) }
  end

  describe 'GET /admin/products/new' do
    before { expect_any_instance_of(Admin::ProductPolicy).to receive(:new?).and_return true }

    subject { get new_admin_product_path }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status :success
    end
  end

  describe 'PATCH /admin/products/:id/edit' do
    let!(:product) { create(:product) }
    let(:new_price) { 111 }
    let(:image) { fixture_file_upload('spec/fixtures/thumbs-up.png') }
    let(:params) do
      { product: { name: 'new_name', price: new_price, images: [] } }
    end

    before { expect_any_instance_of(Admin::ProductPolicy).to receive(:update?).and_return true }

    subject { patch admin_product_path(product), params: params }

    context 'update name and price' do
      let(:params) do
        { product: { name: 'new_name', price: new_price } }
      end

      it 'updates product attributes' do
        expect(product).not_to have_attributes(params[:product])

        subject

        expect(product.reload).to have_attributes(params[:product])
      end
    end

    context 'update image' do
      let(:params) do
        { product: { images: [image] } }
      end

      it 'updates product images' do
        expect(product.images.count).to eq 0

        subject

        expect(product.images.count).to eq 1
        expect(product.images.first.filename.to_s).to eq image.original_filename
      end
    end
  end

  describe 'GET /admin/products/:id/edit' do
    let!(:product) { create(:product) }

    before { expect_any_instance_of(Admin::ProductPolicy).to receive(:edit?).and_return true }

    subject { get edit_admin_product_path(product) }

    it 'renders successfully' do
      subject
      expect(response).to have_http_status :success
      expect(response.body).to include product.name
    end
  end
end
