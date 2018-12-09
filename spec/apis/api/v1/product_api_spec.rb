require 'rails_helper'

describe API::V1::ProductAPI, type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/products' do
    let(:params) { { page: 1, per_page: 2 } }

    subject { get '/api/v1/products', params: params }

    before do
      sign_in user
      create_list(:product, 5)
    end

    it 'responses 200 and paginated products' do
      subject

      products = Product.all.page(params[:page]).per(params[:per_page])
      expect(response).to have_http_status 200
      expect(response.body).to eq Entity::V1::PaginatedProduct.represent(products).to_json
    end

    context 'when no login session' do
      before { sign_out user }

      it 'responses 401' do
        subject
        expect(response).to have_http_status 401
      end
    end
  end
end
