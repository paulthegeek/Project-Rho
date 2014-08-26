require 'spec_helper'
require 'pry'

describe 'Publishers API', type: :request do
  let!(:pub) { FactoryGirl.create :publisher }
  let!(:pub_2) { FactoryGirl.create :publisher, name: 'Marvel' }

  context 'index resources are found' do
    describe 'GET /publishers' do
      it 'responds with 200' do
        get '/publishers'
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'publisher keys' do
      let(:pub_keys) { json['publishers'].first }

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

  context 'show resources are found' do
    describe 'GET /publishers/:id' do
      it 'returns publisher by id' do
        get "/publishers/#{pub.id}"
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'publisher keys' do
      let(:pub_keys) { json['publishers'] }

      it 'contains id key' do
        get "/publishers/#{pub.id}"
        expect(pub_keys).to have_key('id')
      end
      it 'contains name key' do
        get "/publishers/#{pub.id}"
        expect(pub_keys).to have_key('name')
      end
    end
  end

  context 'valid publisher attributes' do
    describe 'POST /publishers' do
      it 'creates a publisher' do
        post '/publishers', :publisher => {name: 'Image'}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:created)
      end

      it 'responses with location' do
        post '/publishers', :publisher => {name: 'DC'}
        expect(response.location).not_to eq nil
      end
    end
  end
  context 'invalid publisher attributes' do
    describe 'POST /publishers' do
      it 'does not create a publisher' do
        post 'publishers', :publisher => {name: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'valid publisher attributes' do
    describe 'PATCH /publishers/:id' do
      let!(:update_pub) { FactoryGirl.create :publisher, name: 'Pubs' }
      it 'creates a publisher' do
        patch "/publishers/#{update_pub.id}", :publisher => {name: 'Pubs Edit'}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end

      it 'responses with location' do
        patch "/publishers/#{update_pub.id}", :publisher => {name: 'Pubs Edit Location'}
        expect(response.location).not_to eq nil
      end
    end
  end
  context 'invalid publisher attributes' do
    describe 'PATCH /publishers/:id' do
      let!(:update_pub) { FactoryGirl.create :publisher, name: 'Pubs' }
      it 'does not update a publisher' do
        patch "/publishers/#{update_pub.id}", :publisher => {name: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'publisher is found' do
    describe 'DELETE /publishers/:id' do
      let!(:archive_pub) { FactoryGirl.create :publisher, name: 'arc_pub', archived: false }

      it 'archives the publisher' do
        delete "/publishers/#{archive_pub.id}"
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
