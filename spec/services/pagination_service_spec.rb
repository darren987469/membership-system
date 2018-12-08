require 'rails_helper'

describe PaginationService do
  let!(:users) { create_list(:user, 5) }

  describe '#pages' do
    subject { described_class.new(collection).pages }

    context 'first page' do
      let(:collection) { User.page(1).per(1) }
      it { expect(subject).to eq next: 2, last: 5 }
    end

    context 'second page' do
      let(:collection) { User.page(2).per(1) }
      it { expect(subject).to eq first: 1, prev: 1, next: 3, last: 5 }
    end

    context 'third page' do
      let(:collection) { User.page(3).per(1) }
      it { expect(subject).to eq first: 1, prev: 2, next: 4, last: 5 }
    end

    context 'fourth page' do
      let(:collection) { User.page(4).per(1) }
      it { expect(subject).to eq first: 1, prev: 3, next: 5, last: 5 }
    end

    context 'last page' do
      let(:collection) { User.page(5).per(1) }
      it { expect(subject).to eq first: 1, prev: 4 }
    end

    context 'out of range page' do
      let(:collection) { User.page(10).per(1) }
      it { expect(subject).to eq({}) }
    end
  end

  describe '#links' do
    let(:url) { make_url(page: 1, per_page: 1) }
    let(:request_env) { Rack::MockRequest.env_for(url) }
    let(:request) { Rack::Request.new(request_env) }

    def make_url(page:, per_page:)
      "http://localhost:3000/api/v1/users?page=#{page}&per_page=#{per_page}"
    end

    subject { described_class.new(collection).links(request) }

    context 'first page' do
      let(:collection) { User.page(1).per(1) }
      let(:expected) do
        {
          next: make_url(page: 2, per_page: 1),
          last: make_url(page: 5, per_page: 1)
        }
      end
      it { expect(subject).to eq expected }
    end

    context 'second page' do
      let(:collection) { User.page(2).per(1) }
      let(:expected) do
        {
          first: make_url(page: 1, per_page: 1),
          prev: make_url(page: 1, per_page: 1),
          next: make_url(page: 3, per_page: 1),
          last: make_url(page: 5, per_page: 1)
        }
      end
      it { expect(subject).to eq expected }
    end

    context 'third page' do
      let(:collection) { User.page(3).per(1) }
      let(:expected) do
        {
          first: make_url(page: 1, per_page: 1),
          prev: make_url(page: 2, per_page: 1),
          next: make_url(page: 4, per_page: 1),
          last: make_url(page: 5, per_page: 1)
        }
      end
      it { expect(subject).to eq expected }
    end

    context 'fourth page' do
      let(:collection) { User.page(4).per(1) }
      let(:expected) do
        {
          first: make_url(page: 1, per_page: 1),
          prev: make_url(page: 3, per_page: 1),
          next: make_url(page: 5, per_page: 1),
          last: make_url(page: 5, per_page: 1)
        }
      end
      it { expect(subject).to eq expected }
    end

    context 'last page' do
      let(:collection) { User.page(5).per(1) }
      let(:expected) do
        {
          first: make_url(page: 1, per_page: 1),
          prev: make_url(page: 4, per_page: 1)
        }
      end
      it { expect(subject).to eq expected }
    end

    context 'out of range page' do
      let(:collection) { User.page(10).per(1) }
      it { expect(subject).to eq({}) }
    end
  end
end
