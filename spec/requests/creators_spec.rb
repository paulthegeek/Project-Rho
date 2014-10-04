require 'spec_helper'

describe 'Creators API', type: :request do
  let!(:creator) { FactoryGirl.create :creator }

  context 'index resources are found' do
    describe 'GET creators' do
      it 'responds with 200' do
        get '/creators'
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'creator keys' do
      let(:creator_keys) { json['creators'].first }

      it 'contains id key' do
        get '/creators', format: :json
        expect(creator_keys).to have_key('id')
      end

      it 'contains name key' do
        get '/creators', format: :json
        expect(creator_keys).to have_key('name')
      end

      it 'contains role key' do
        get '/creators', format: :json
        expect(creator_keys).to have_key('role')
      end
    end
  end

  context 'show resources are found' do
    describe 'GET creators/:id' do
      it 'returns creator by id' do
        get "creators/#{creator.id}"
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'creator keys' do
      let(:creator_keys) { json['creators'] }

      it 'contains id key' do
        get "/creators/#{creator.id}"
        expect(creator_keys).to have_key('id')
      end

      it 'contains name key' do
        get "/creators/#{creator.id}"
        expect(creator_keys).to have_key('name')
      end

      it 'contains role key' do
        get "/creators/#{creator.id}"
        expect(creator_keys).to have_key('role')
      end
    end
  end

  context 'valid creator attributes' do
    describe 'POST creators' do
      it 'creates a creator' do
        post '/creators', creator: { name: 'created_creator', role: 'writer' }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:created)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid creator attributes' do
    describe 'POST creators' do
      it 'does not create a creator with empty name' do
        post '/creators', creator: { name: nil }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a creator with empty role' do
        post '/creators', creator: { role: nil }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'valid creator attributes' do
    describe 'PATCH creators/:id' do
      let!(:update_creator) { FactoryGirl.create :creator, name: 'Update Creator', role: 'writer' }

      it 'creates a creator' do
        patch "/creators/#{update_creator.id}", creator: { name: 'Creator Updated', role: 'artist' }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid creator attributes' do
    describe 'PATCH creators/:id' do
      let!(:update_creator) { FactoryGirl.create :creator, name: 'Update Creator' }

      it 'does not update a creator with empty name' do
        patch "creators/#{update_creator.id}", creator:{ name: nil }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update a creator with empty role' do
        patch "creators/#{update_creator.id}", creator: { role: nil }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'creator is found' do
    describe 'DELETE creators/:id' do
      let!(:archive_creator) { FactoryGirl.create :creator, name: 'arc_creator', role: 'artist', archived: false }

      it 'archives the creator' do
        delete "creators/#{archive_creator.id}"
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
