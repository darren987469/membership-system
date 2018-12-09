require 'rails_helper'

describe Helper::Pagination do
  describe '.paginated_entity_class' do
    before do
      class IdEntity < Grape::Entity
        expose :id
      end
    end
    let(:entity_class) { described_class.paginated_entity_class(IdEntity) }

    it 'returns a class extend Grape::Entity' do
      expect(entity_class.ancestors).to include Grape::Entity
    end

    it 'documents every attributes' do
      expect(entity_class.documentation.keys).to match_array %i[results page per_page total_count]
    end

    it 'accepts paginated collection' do
      create_list(:user, 5)
      collection = User.all.page(1).per(2)

      subject = entity_class.represent(collection).as_json

      expected_collection = collection.map { |record| IdEntity.represent(record).as_json }
      expect(subject[:results]).to eq expected_collection
      expect(subject[:page]).to eq 1
      expect(subject[:per_page]).to eq 2
      expect(subject[:total_count]).to eq 5
    end
  end
end
