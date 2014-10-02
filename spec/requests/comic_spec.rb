require 'spec_helper'

describe 'Comics API', type: :request do
  let!(:comic)   { FactoryGirl.create :comic }
  let!(:variant) { FactoryGirl.create :comic_variant }
  let!(:reprint) { FactoryGirl.create :comic_reprint }
  context 'index resources are found' do
    describe 'GET comics' do
      it 'responds with status ok' do
        get '/comics', format: :json
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'comic attributes' do
      let(:comic_keys) { json['comics'].first }

      it 'contains comic attributes' do
        get '/comics', format: :json
        expect(comic_keys).to have_key('id')
        expect(comic_keys).to have_key('title')
        expect(comic_keys).to have_key('price')
        expect(comic_keys).to have_key('image_id')
        expect(comic_keys).to have_key('comic_series_id')
        expect(comic_keys).to have_key('publisher_id')
        expect(comic_keys).to have_key('release_date')
        expect(comic_keys).to have_key('variant')
        expect(comic_keys).to have_key('reprint')
        expect(comic_keys).to have_key('archived')
      end
    end

    context 'is a variant' do
      describe 'GET comic' do
        it 'responds with status ok' do
          get '/comics', { format: :json, variant: true }
          expect(response.content_type).to eq Mime::JSON
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'comic attributes' do
        let(:comic_keys) { json['comics'].first }

        it 'contains comic attributes' do
          get '/comics', { format: :json, variant: true }
          expect(comic_keys).to have_key('id')
          expect(comic_keys).to have_key('title')
          expect(comic_keys).to have_key('price')
          expect(comic_keys).to have_key('image_id')
          expect(comic_keys).to have_key('comic_series_id')
          expect(comic_keys).to have_key('publisher_id')
          expect(comic_keys).to have_key('release_date')
          expect(comic_keys).to have_key('variant')
          expect(comic_keys).to have_key('reprint')
          expect(comic_keys).to have_key('archived')
        end
      end
    end

    context 'is a reprint' do
      describe 'GET comic' do
        it 'responds with status ok' do
          get '/comics', { format: :json, reprint: true }
          expect(response.content_type).to eq Mime::JSON
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'comic attributes' do
        let(:comic_keys) { json['comics'].first }

        it 'contains comic attributes' do
          get '/comics', { format: :json, reprint: true }
          expect(comic_keys).to have_key('id')
          expect(comic_keys).to have_key('title')
          expect(comic_keys).to have_key('price')
          expect(comic_keys).to have_key('image_id')
          expect(comic_keys).to have_key('comic_series_id')
          expect(comic_keys).to have_key('publisher_id')
          expect(comic_keys).to have_key('release_date')
          expect(comic_keys).to have_key('variant')
          expect(comic_keys).to have_key('reprint')
          expect(comic_keys).to have_key('archived')
        end
      end
    end
  end

  context 'show resources are found' do
    describe 'GET comic/:id' do
      it 'returns comic by id' do
        get "/comics/#{comic.id}", { format: :json }
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'comic attributes' do
      let(:comic_keys) { json['comics'] }

      it 'contains comic attributes' do
        get "/comics/#{comic.id}", { format: :json }
        expect(comic_keys).to have_key('id')
        expect(comic_keys).to have_key('title')
        expect(comic_keys).to have_key('price')
        expect(comic_keys).to have_key('image_id')
        expect(comic_keys).to have_key('comic_series_id')
        expect(comic_keys).to have_key('publisher_id')
        expect(comic_keys).to have_key('release_date')
        expect(comic_keys).to have_key('variant')
        expect(comic_keys).to have_key('reprint')
        expect(comic_keys).to have_key('archived')
      end
    end
  end

  context 'valid comic attributes' do
    describe 'POST comic' do
      it 'creates a comic' do
        post '/comics', comic: {title: 'created_comic', price: 4.99, image_id: 51, 
                                comic_series_id: 54, publisher_id: 1, release_date: DateTime.now}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:created)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid comic attributes' do
    describe 'POST comic' do
      it 'does not create a comic with an empty title' do
        post '/comics', comic: {title: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic with an empty sub_id' do
        post '/comics', comic: {price: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic with an empty archive' do
        post '/comics', comic: {image_id: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic with an empty archive' do
        post '/comics', comic: {comic_series_id: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic with an empty archive' do
        post '/comics', comic: {publisher_id: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a comic with an empty archive' do
        post '/comics', comic: {release_date: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'valid comic attributes' do
    describe 'PATCH comic' do
      let!(:update_comic) { FactoryGirl.create :comic, title: 'Update Comic', price: 4.99, image_id: 1, 
                                                       comic_series_id: 1, publisher_id: 1, release_date: DateTime.now }
      it 'updates comic' do
        patch "/comics/#{update_comic.id}", comic: {title: 'Updated Comic Series', price: 3.99}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:ok)
        expect(response.location).not_to eq nil
      end
    end
  end

  context 'invalid comic series attributes' do
    describe 'PATCH comic_series/:id' do
      let!(:update_comic) { FactoryGirl.create :comic, title: 'Update Comic', price: 4.99, image_id: 1, 
                                                       comic_series_id: 1, publisher_id: 1, release_date: DateTime.now }

      it 'does not update a comic series with an empty name' do
        patch "/comics/#{update_comic.id}", comic: {title: nil}
        expect(response.content_type).to eq Mime::JSON
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'comic is found' do
    describe 'DELETE comic/:id' do
      let!(:archive_comic) { FactoryGirl.create :comic, title: 'Update Comic', price: 4.99, image_id: 1, 
                                                       comic_series_id: 1, publisher_id: 1, release_date: DateTime.now }

      it 'archives the creator' do
        delete "/comics/#{archive_comic.id}"
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end