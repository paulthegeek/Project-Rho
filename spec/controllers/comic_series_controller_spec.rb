# require 'spec_helper'
#
# describe ComicSeriesController do
#   let(:series_1) { FactoryGirl.create :comic_series }
#   describe 'GET #index' do
#     it 'gets all the comic series' do
#       series_2 = FactoryGirl.create(:comic_series, name: 'S2', sub_id: 543)
#
#       get :index
#       expect(assigns(:comic_series)).to match_array([series_1, series_2])
#     end
#
#     it 'gets all the comic series with no id' do
#       no_sub_id = FactoryGirl.create(:comic_series, name: 'no_id', sub_id: 0)
#
#       get :index
#       expect(assigns(:cs_no_id)).to match_array([no_sub_id])
#     end
#
#     it 'renders index template' do
#       get :index
#       expect(response).to render_template(:index)
#     end
#   end
#
#   describe 'GET #new' do
#     it 'assigns a new comic series to @single_comic_series' do
#       get :new
#       expect(assigns(:single_comic_series)).to be_a_new(ComicSeries)
#     end
#
#     it 'renders new template' do
#       get :new
#       expect(response).to render_template(:new)
#     end
#   end
#
#   describe 'POST #create' do
#     context 'with valid parameters' do
#       let(:valid_attributes) { FactoryGirl.attributes_for(:comic_series) }
#       it 'save new comic series' do
#         expect{
#           post :create, comic_series: valid_attributes
#         }.to change(ComicSeries, :count).by(1)
#       end
#
#       it 'redirects to comic_series#index' do
#         post :create, comic_series: valid_attributes
#         expect(response).to redirect_to(comic_series_index_path)
#       end
#     end
#
#     context 'with invalid attributes' do
#       let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_comic_series) }
#
#       it 'does not save new comic series' do
#         expect{
#           post :create, comic_series: invalid_attributes
#         }.to_not change(ComicSeries, :count)
#       end
#
#       it 're-renders the :new template' do
#         post :create, comic_series: invalid_attributes
#         expect(response).to render_template :new
#       end
#     end
#   end
#
#   describe "GET #edit" do
#     it 'finds the requested comic_series' do
#       get :edit, id: series_1
#       expect(assigns(:single_comic_series)).to eq series_1
#     end
#
#     it 'renders edit template' do
#       get :edit, id: series_1
#       expect(response).to render_template :edit
#     end
#   end
#
#   describe "PATCH #update" do
#     context 'with valid attributes' do
#       it 'finds the requested comic_series' do
#         patch :update, id: series_1, comic_series: FactoryGirl.attributes_for(:comic_series)
#         expect(assigns(:comic_series)).to eq series_1
#       end
#
#       it 'changes @comic_series attributes' do
#         patch :update, id: series_1, comic_series: FactoryGirl.attributes_for(:comic_series, name: 'Captain Marvel')
#         series_1.reload
#         expect(series_1.name).to eq 'Captain Marvel'
#       end
#
#       it 'redirects to index' do
#         patch :update, id: series_1, comic_series: FactoryGirl.attributes_for(:comic_series)
#         expect(response).to redirect_to(comic_series_index_path)
#       end
#     end
#
#     context 'with invalid attributes' do
#       before :each do
#         patch :update, id: series_1,
#           comic_series: FactoryGirl.attributes_for(:comic_series, name: nil)
#       end
#
#       it 'does not change @comic_series attributes' do
#         series_1.reload
#         expect(series_1.name).to_not eq nil
#       end
#
#       it 'redirects to index' do
#         expect(response).to render_template :edit
#       end
#     end
#   end
#
#   describe 'DELETE #destroy' do
#     let!(:series) { FactoryGirl.create(:comic_series) }
#
#     it 'deletes comic series' do
#       expect{
#         delete :destroy, id: series
#       }.to change(ComicSeries, :count).by(-1)
#     end
#
#     it 'redirects to index' do
#       delete :destroy, id: series
#       expect(response).to redirect_to(comic_series_index_path)
#     end
#   end
# end
