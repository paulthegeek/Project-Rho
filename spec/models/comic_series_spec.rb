require 'spec_helper'

describe ComicSeries do
  context 'validations' do
    it { should validate_presence_of :name }
  end

  context 'has no subscription id' do
    describe '#has_no_sub_id' do
      let(:series_with_id)    { FactoryGirl.create(:comic_series, name: 'with_id', sub_id: 123) }
      let(:series_without_id) { FactoryGirl.create(:comic_series, name: 'no_id', sub_id: 0) }
      it "returns series' where sub_id is 0/nil" do
        expect(ComicSeries.has_no_sub_id).to match_array([series_without_id])
      end
    end
  end
end
