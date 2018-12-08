require 'rails_helper'

describe API::V1::Admin::UserAPI, type: :request do
  describe 'GET /api/v1/admin/users' do
    let(:user) { create(:user, role: :owner) }
    let(:params) { { page: 1, per_page: 3 } }

    subject { get '/api/v1/admin/users', params: params }

    before do
      sign_in user
      create_list(:user, 5)

      expect_any_instance_of(Admin::UserPolicy).to receive(:index?).and_return(true)
    end

    it 'returns 200 and paginated users' do
      subject
      expect(response).to have_http_status 200

      users = User.page(params[:page]).per(params[:per_page])
      links = PaginationService.new(users).links(request)
      paginated_users = OpenStruct.new(
        collection: users,
        links: OpenStruct.new(links)
      )

      expected_body = Entity::V1::PaginatedUser.represent(paginated_users).to_json
      expect(response.body).to eq expected_body
    end
  end
end
