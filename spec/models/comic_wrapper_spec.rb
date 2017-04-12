require 'rails_helper'
RSpec.describe ComicWrapper do
  subject(:wrapped_comic) { described_class.new(MarvelApiTestResponses::COMIC)}

  its(:id) { is_expected.to eq 1749 }

  describe '#title' do
    it 'contains only the name' do
      expect(wrapped_comic.title).to eq "Official Handbook of the Marvel Universe (X-MEN - AGE OF APOCALYPSE)"
    end
  end

  describe '#year' do
    it 'parses the year out of the raw title' do
      expect(wrapped_comic.year).to eq '2004'
    end
  end

  describe '#edition' do
    it 'parses the edition out of the raw title' do
      expect(wrapped_comic.edition).to eq '#11'
    end
  end

  describe '#image_url' do
    it 'will create a valid image url from the url given' do
      expect(wrapped_comic.image_url).to eq "http://i.annihil.us/u/prod/marvel/i/mg/c/b0/4bc6494ed6eb4/portrait_incredible.jpg"
    end
  end

  describe '#favourited?' do
    it 'will check if an id is favourited' do
      expect(Favourite).to receive(:favourited?).with(1749)
      wrapped_comic.favourited?
    end
  end

  describe '#as_json' do
    it 'returns the correct data' do
      expect(wrapped_comic.as_json)
        .to eq ({
        title: wrapped_comic.title,
        year: wrapped_comic.year,
        edition: wrapped_comic.edition,
        id: wrapped_comic.id,
        imageUrl: wrapped_comic.image_url,
        isFavourited: wrapped_comic.favourited?
      })
    end
  end
end
