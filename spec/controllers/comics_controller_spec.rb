require 'rails_helper'
RSpec.describe ComicsController do
  let(:comic) { double 'comic' }
  let(:comics) { [comic, comic, comic] }
  let(:marvel_api_instance) { double 'marvel_api_instance', comics: comics }

  before do
    allow(MarvelApi).to receive(:new).and_return marvel_api_instance
  end

  describe 'index' do
    it 'will return the comics from the marvel api' do
      get :index
      expect(assigns(:comics)).to eq comics
    end
  end

  describe 'fetch' do
    context 'calling marvel api with relevant params' do
      context 'when no params are given' do
        it 'calls marvel api with reasonable arguments' do
          expect(MarvelApi).to receive(:new).with(character: nil, set: 1)
          get :fetch
        end
      end
    end

    context 'with params' do
      it 'calls marvel api with the correct arguments' do
        expect(MarvelApi).to receive(:new).with(character: 'deadpool', set: 2)
        get :fetch, params: { character: 'deadpool', set: 2 }
      end
    end
  end
end
