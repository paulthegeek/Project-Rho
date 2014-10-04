require 'spec_helper'

describe ComicsController, type: :controller do
  describe 'GET #index' do
    let(:comic_1) { FactoryGirl.create :comic }
    let(:comic_2) { FactoryGirl.create :comic, title: 'Comic_2', price: 4.99 }

    it 'response with all comics' do
      get :index, format: :json
      expect(assigns(:comics)).to match_array([comic_1, comic_2])
    end

    it 'renders index template' do
      get :index, format: :json
      expect(response).to render_template(:index)
    end

    context 'being a variant comic' do
      let!(:variant)     { FactoryGirl.create :comic_variant }
      let!(:non_variant) { FactoryGirl.create :comic}

      it 'gets all comics that are variants' do
        get :index, { variant: 'true', format: :json }
        expect(assigns(:comics)).to match_array([variant])
      end
    end

    context 'being a reprint comic' do
      let!(:reprint)     { FactoryGirl.create :comic_reprint }
      let!(:non_reprint) { FactoryGirl.create :comic }

      it 'gets all the comics that are reprints' do
        get :index, { reprint: 'true', format: :json }
        expect(assigns(:comics)).to match_array([reprint])
      end
    end
  end

  describe 'GET #show' do
    let(:comic_1) { FactoryGirl.create :comic }

    it 'assigns the requested comic to @comic' do
      get :show, id: comic_1, format: :json
      expect(assigns(:comic)).to eq comic_1
    end

    it 'renders show template' do
      get :show, id: comic_1, format: :json
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryGirl.attributes_for(:comic) }

      it 'creates a new comic' do
        expect{
          post :create, comic: valid_attributes, format: :json
        }.to change(Comic, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_comic) }

      it 'does not save new comic' do
        expect{
          post :create, comic: invalid_attributes, format: :json
        }.to_not change(Comic, :count)
      end
    end
  end

  describe "PATCH #update" do
    let(:comic_update) { FactoryGirl.create :comic }
    let(:comic_update_invalid) { FactoryGirl.create :comic }
    context 'with valid attributes' do
      it 'finds the requested comic' do
        patch :update, id: comic_update, comic: FactoryGirl.attributes_for(:comic), format: :json
        expect(assigns(:comic)).to eq comic_update
      end

      it 'changes @comic attributes' do
        patch :update, id: comic_update, comic: FactoryGirl.attributes_for(:comic, title: 'Captain Marvel #1'), format: :json
        comic_update.reload
        expect(comic_update.title).to eq 'Captain Marvel #1'
      end
    end

    context 'with invalid attributes' do
      before :each do
        patch :update, id: comic_update_invalid,
          comic: FactoryGirl.attributes_for(:comic, title: nil), format: :json
      end

      it 'does not change @comic attributes' do
        comic_update_invalid.reload
        expect(comic_update_invalid.title).to_not eq nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:comic_delete) { FactoryGirl.create(:comic, title: 'X-Men #1', archived: false) }

    it 'archives comic series' do
      delete :destroy, id: comic_delete
      expect(comic_delete.archive).to eq true
    end
  end
end