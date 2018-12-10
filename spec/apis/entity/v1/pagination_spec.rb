require 'rails_helper'

describe Entity::V1::Pagination do
  let(:klass) do
    Class.new(described_class) do
      present_collection true, :collection
      expose :collection, as: :results
    end
  end
  let(:page) { 2 }
  let(:per) { 3 }
  let(:users) { User.page(page).per(per) }

  before { create_list(:user, 5) }

  subject { klass.represent(users).as_json }

  it { expect(subject[:results].size).to eq users.size }
  it { expect(subject[:page]).to eq page }
  it { expect(subject[:per_page]).to eq per }
  it { expect(subject[:total_pages]).to eq users.total_pages }
  it { expect(subject[:total_count]).to eq User.count }
  it { expect(subject[:page_entries_info]).to eq 'Displaying users 4 - 5 of 5 in total' }
end
