require 'spec_helper'

describe 'Comic Series API', type: :request do
  let!(:comic_series) { FactoryGirl.create :comic_series }
  let!(:no_sub_id) { FactoryGirl.create :no_sub_id_comic_series }

  context 'index resources are found' do
    describe 'GET comic series' do
      it 'responds with status ok' do
        get '/comic_series', { format: :json }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'comic series attributes' do
      let(:comic_series_keys) { json['comic_series'].first }

      it 'contains comic series attributes' do
        get '/comic_series', { format: :json }
        expect(comic_series_keys).to have_key('id')
        expect(comic_series_keys).to have_key('name')
        expect(comic_series_keys).to have_key('sub_id')
        expect(comic_series_keys).to have_key('archived')
      end
    end

    context 'with no sub id' do
      describe 'GET comic series' do
        it 'responds with status ok' do
          get '/comic_series', { format: :json, no_sub_id: true }
          expect(response.content_type).to eq Mime::JSON
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'comic series attributes' do
        let(:comic_series_keys) { json['comic_series'].first }

        it 'contains comic series attributes' do
          get '/comic_series', { format: :json, no_sub_id: true }
          expect(comic_series_keys).to have_key('id')
          expect(comic_series_keys).to have_key('name')
          expect(comic_series_keys).to have_key('sub_id')
          expect(comic_series_keys).to have_key('archived')
        end
      end
    end
  end

  context 'show resources are found' do
    describe 'GET comic_series/:id' do
      it 'returns comic series by id' do
        get "/comic_series/#{comic_series.id}", { format: :json }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'comic series attributes' do
      let(:comic_series_keys) { json['comic_series'] }

      it 'contains comic series attributes' do
        get "/comic_series/#{comic_series.id}", { format: :json }
        expect(comic_series_keys).to have_key('id')
        expect(comic_series_keys).to have_key('name')
        expect(comic_series_keys).to have_key('sub_id')
        expect(comic_series_keys).to have_key('archived')
      end
    end
  end

  context 'valid comic series attributes' do
    describe 'POST comic series' do
      it 'creates a comic series' do
        post '/comic_series', comic_series: {name: 'created_comic_series', sub_id: 1234455, archived: false}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:created)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid comic series attributes' do
    describe 'POST comic series' do
      it 'does not create a comic series with an empty name' do
        post '/comic_series', comic_series: {name: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic series with an empty sub_id' do
        post '/comic_series', comic_series: {sub_id: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic series with an empty archive' do
        post '/comic_series', comic_series: {archived: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'valid comic series attributes' do
    describe 'PATCH comic series' do
      let!(:update_comic_series) { FactoryGirl.create :comic_series, name: 'Update Comic Series', sub_id: 23, archived: false }

      it 'updates comic series' do
        patch "/comic_series/#{update_comic_series.id}", comic_series: {name: 'Updated Comic Series', sub_id: 43, archived: true }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid comic series attributes' do
    describe 'PATCH comic_series/:id' do
      let!(:update_comic_series) { FactoryGirl.create :comic_series, name: 'Update Comic Series', sub_id: 24, archived: false }

      it 'does not update a comic series with an empty name' do
        patch "/comic_series/#{update_comic_series.id}", comic_series: {name: nil, sub_id: 43, archived: true}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'comic series is found' do
    describe 'DELETE comic_series/:id' do
      let!(:archive_comic_series) { FactoryGirl.create :comic_series, name: 'comic_series_delete', sub_id: 25, archived: false }

      it 'archives the creator' do
        delete "/comic_series/#{archive_comic_series.id}"
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
