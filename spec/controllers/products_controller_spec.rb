require 'rails_helper'

describe ProductsController, type: :request do
  include ActionView::Helpers::UrlHelper

  let(:user) { create(:user) }

  describe 'GET /products' do
    subject { get '/products' }

    context 'when no user session' do
      it 'redirects to sign in page' do
        expect(subject).to redirect_to new_user_session_path
      end
    end

    context 'when user session exists' do
      before { sign_in user }

      it 'renders user email' do
        subject
        expect(response.body).to include user.email
      end

      it 'renders user membership' do
        subject
        expect(response.body).to include "Membership: #{user.role}"
      end

      it 'renders logout link' do
        subject

        logout_link = link_to('Logout', destroy_user_session_path, method: :delete)
        expect(response.body).to include logout_link
      end
    end
  end
end
