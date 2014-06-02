require 'spec_helper'

describe Creator do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
    it { should have_and_belong_to_many :comics }
  end
end
