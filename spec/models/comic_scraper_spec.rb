require 'spec_helper'

describe ComicScraper do
  describe 'initialization' do
    it 'formats date into string with proper format' do
      wednesday = Date.new(2015, 01, 07)
      this_wednesday = wednesday.strftime('%m/%d/%y')
      expect(this_wednesday).to eq '01/07/15'
    end 
  end
end
