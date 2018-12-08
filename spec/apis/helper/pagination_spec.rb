require 'rails_helper'

describe Helper::Pagination do
  describe '.paginated_entity_class' do
    before do
      class IdEntity < Grape::Entity
        expose :id
      end
    end

    subject { described_class.paginated_entity_class(IdEntity) }

    it 'returns a class extend Grape::Entity' do
      expect(subject.ancestors).to include Grape::Entity
    end

    it 'documents every attributes' do
      expect(subject.documentation.keys).to match_array %i[results links page per_page]
    end
  end

  describe '#paginated_object' do
    let(:request_env) { Rack::MockRequest.env_for('http://localhost:3000') }
    let(:request) { Rack::Request.new(request_env) }
    let(:collection) { User.page(1).per(1) }
    let(:klass) do
      Class.new do
        include Helper::Pagination

        attr_reader :params, :request

        def initialize(params, request)
          @params = params
          @request = request
        end
      end
    end
    let(:params) { { page: 1, per_page: 1 } }
    let(:instance) { klass.new(params, request) }

    subject { instance.paginated_object(collection) }

    before { create_list(:user, 3) }

    it 'responds to collection' do
      expect(subject.collection).to eq collection
    end

    it 'responds to links' do
      links = PaginationService.new(collection).links(request)
      expect(subject.links).to eq OpenStruct.new(links)
    end
  end
end
