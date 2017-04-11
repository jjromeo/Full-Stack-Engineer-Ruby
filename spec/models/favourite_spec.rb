require 'rails_helper'
RSpec.describe Favourite do
  it { should validate_uniqueness_of :comic_id }

  describe '.favourited?' do
    it 'knows when a comic id has been favourited' do
      create(:favourite, comic_id: 34555)
      expect(described_class.favourited?(34555)).to eq true
    end

    it 'knows when a comic id has not been favourited' do
      expect(described_class.favourited?(123)).to eq false
    end
  end
end
