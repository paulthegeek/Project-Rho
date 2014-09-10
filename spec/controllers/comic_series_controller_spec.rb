require 'spec_helper'

describe ComicSeriesController, type: :controller do
  let(:series_1) { FactoryGirl.create :comic_series }

  describe 'GET #index' do
    it 'gets all comic series' do
      series_2 = FactoryGirl.create(:comic_series, name: 'S2', sub_id: 543)

      get :index, { format: :json }
      expect(assigns(:comic_series)).to match_array([series_1, series_2])
    end

    it 'renders index template' do
      get :index, { format: :json }
      expect(response).to render_template(:index)
    end
  end

  context 'with no sub id' do
    describe 'GET #index' do
      let(:no_sub_id) { FactoryGirl.create :no_sub_id_comic_series }

      it 'gets all comic series with sub id of 0' do
        get :index, { no_sub_id: true, format: :json }
        expect(assigns(:comic_series)).to match_array([no_sub_id])
      end
    end
  end

  describe 'GET #show' do
    let(:cs_1) { FactoryGirl.create :comic_series }

    it 'assigns the requested comic series to @comic_series' do
      get :show, id: cs_1, format: :json
      expect(assigns(:single_comic_series)).to eq cs_1
    end

    it 'renders show template' do
      get :show, id: cs_1, format: :json
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryGirl.attributes_for(:comic_series) }

      it 'creates a new comic series' do
        expect{
          post :create, comic_series: valid_attributes, format: :json
        }.to change(ComicSeries, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_comic_series) }

      it 'does not save new comic series' do
        expect{
          post :create, comic_series: invalid_attributes, format: :json
        }.to_not change(ComicSeries, :count)
      end
    end
  end

  describe "PATCH #update" do
    let(:cs_update) { FactoryGirl.create :comic_series }
    context 'with valid attributes' do
      it 'finds the requested comic_series' do
        patch :update, id: cs_update, comic_series: FactoryGirl.attributes_for(:comic_series), format: :json
        expect(assigns(:single_comic_series)).to eq cs_update
      end

      it 'changes @comic_series attributes' do
        patch :update, id: cs_update, comic_series: FactoryGirl.attributes_for(:comic_series, name: 'Captain Marvel'), format: :json
        cs_update.reload
        expect(cs_update.name).to eq 'Captain Marvel'
      end
    end

    context 'with invalid attributes' do
      before :each do
        patch :update, id: series_1,
          comic_series: FactoryGirl.attributes_for(:comic_series, name: nil), format: :json
      end

      it 'does not change @comic_series attributes' do
        series_1.reload
        expect(series_1.name).to_not eq nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:cs_delete) { FactoryGirl.create(:comic_series, name: 'X-Men', archived: false) }

    it 'archives comic series' do
      delete :destroy, id: cs_delete
      expect(cs_delete.archive).to eq true
    end
  end
end
