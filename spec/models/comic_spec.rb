require 'spec_helper'

describe Comic do
  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image_id }
    it { should validate_presence_of :series_id }
    it { should validate_presence_of :publisher_id }
    it { should validate_presence_of :release_date }
  end
end
