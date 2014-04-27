require 'spec_helper'

describe Publisher do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should have_many :comics }
  end
end
