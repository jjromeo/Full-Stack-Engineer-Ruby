require 'rails_helper'
RSpec.describe MarvelUrlHelper do
  let(:offset) { {offset: 0} }
  let(:comic_params) {{ orderBy: MarvelApi::ORDER_BY, limit: MarvelApi::LIMIT }}
  subject(:marvel_url_helper) { described_class.new(order_by: MarvelApi::ORDER_BY, limit: MarvelApi::LIMIT) }
  describe '#comics_url' do
    context 'standard url' do
      let(:expected_comics_url) { URI::HTTPS.build(host: MarvelUrlHelper::HOST, path: "#{MarvelUrlHelper::BASE_PATH}/comics", query: comic_params.merge(offset).to_query ) }

      its(:comics_url) { is_expected.to eq expected_comics_url }
    end

    context 'with an offset' do
      let(:offset) { {offset: 1} }
      let(:expected_comics_url) { URI::HTTPS.build(host: MarvelUrlHelper::HOST, path: "#{MarvelUrlHelper::BASE_PATH}/comics", query: comic_params.merge(offset).to_query ) }

      it 'returns the built url' do
        expect(marvel_url_helper.comics_url(offset: 1)).to eq expected_comics_url
      end
    end
  end

  describe '#character_comics_url' do
    let(:character_id) { 2500 }
    let(:expected_char_com_url) { URI::HTTPS.build(host: MarvelUrlHelper::HOST, path: "#{MarvelUrlHelper::BASE_PATH}/characters/#{character_id}/comics", query: comic_params.merge(offset).to_query ) }

    it 'will return the correct built url' do
      expect(marvel_url_helper.character_comics_url(character_id: character_id)).to eq expected_char_com_url
    end
  end

  describe '#characters_url' do
    let(:char_query) { {name: 'deadpool', limit: 1 } }
    let(:expected_characters_url) { URI::HTTPS.build(host: MarvelUrlHelper::HOST, path: "#{MarvelUrlHelper::BASE_PATH}/characters", query: char_query.to_query ) }

    it 'will return the correct build url' do
      expect(marvel_url_helper.characters_url('deadpool')).to eq expected_characters_url
    end
  end
end
