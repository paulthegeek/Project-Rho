require 'spec_helper'

describe ComicSeries do
  context 'validations' do
    it { should validate_presence_of :name }
  end
end
