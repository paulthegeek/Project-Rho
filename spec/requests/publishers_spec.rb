require 'spec_helper'
require 'pry'

describe 'Publishers API', type: :request do
  let(:pub) { FactoryGirl.create :publisher }
  let(:pub_keys) { json['publishers'].first }

  context 'when publishers are found' do
    describe 'GET /publishers' do
      it 'responds with 200' do
        get '/publishers', format: 'json'
        expect(response).to be_success
      end
    end

    describe 'publisher keys' do
      it 'contains id key' do
        get '/publishers', {format: 'json'}
        expect(pub_keys).to have_key('id')
      end
      it 'contains name key' do
        get '/publishers', {format: 'json'}
        expect(pub_keys).to have_key('name')
      end
    end
  end

end
