require 'rails_helper'

describe Entity::V1::User do
  let(:current_user) { create(:user) }
  let(:user) { create(:user) }
  let(:entity) { described_class.new(user, current_user: current_user) }

  subject { entity.as_json }

  it { expect(subject[:email]).to eq user.email }
  it { expect(subject[:role]).to eq user.role }
end
