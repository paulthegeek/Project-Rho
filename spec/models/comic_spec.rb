require 'spec_helper'

describe Comic do
  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image_id }
    it { should validate_presence_of :comic_series_id }
    it { should validate_presence_of :publisher_id }
    it { should validate_presence_of :release_date }
    it { should belong_to :comic_series }
    it { should have_and_belong_to_many :creators }
  end

  describe '.variant' do
    let(:comic_1) { FactoryGirl.create :comic }
    let(:comic_2) { FactoryGirl.create :comic_variant }
    let(:comic_3) { FactoryGirl.create :comic_variant, title: 'comic_variant_2' }

    it 'returns all the comics with the variant flag' do
      expect(Comic.variant).to match_array([comic_2, comic_3])
    end
  end

  describe '.reprint' do
    let(:comic_1) { FactoryGirl.create :comic }
    let(:comic_2) { FactoryGirl.create :comic_reprint }
    let(:comic_3) { FactoryGirl.create :comic_reprint, title: 'comic_reprint_2' }
    
    it 'returns all the comics with the reprint flag' do
      expect(Comic.reprint).to match_array([comic_2, comic_3])
    end
  end
end
