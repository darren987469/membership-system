require 'rails_helper'

describe Entity::V1::PaginationLinks do
  let(:links) { { first: 'first', prev: 'prev', next: 'next', last: 'last' } }

  subject { described_class.new(OpenStruct.new(links)).as_json }

  context 'attribute is nil' do
    it 'does not expose the attribute' do
      links.keys.each do |key|
        dup_links = links.dup
        dup_links[key] = nil

        entity = described_class.new(OpenStruct.new(dup_links)).as_json
        expect(entity).not_to have_key(key)
      end
    end
  end

  it { expect(subject[:first]).to eq links[:first] }
  it { expect(subject[:prev]).to eq links[:prev] }
  it { expect(subject[:next]).to eq links[:next] }
  it { expect(subject[:last]).to eq links[:last] }
end
