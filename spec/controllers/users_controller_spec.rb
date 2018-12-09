require 'rails_helper'

describe UsersController, type: :request do
  let(:user) { create(:user) }

  describe 'PATCH /users/upgrade_to_premium' do
    subject { patch '/users/upgrade_to_premium' }

    before do
      sign_in user
      expect_any_instance_of(UserPolicy).to receive(:upgrade_to_premium?).and_return true
    end

    it 'updates user role' do
      expect { subject }.to change { user.reload.role }.from('normal').to('premium')
    end

    it 'redirect to products page' do
      expect(subject).to redirect_to products_path
    end
  end
end
