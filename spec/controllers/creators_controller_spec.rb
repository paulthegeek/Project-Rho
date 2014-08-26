require 'spec_helper'

describe CreatorsController, type: :controller do
  describe 'GET #index' do
    let(:cre_1) { FactoryGirl.create :creator }
    let(:cre_2) { FactoryGirl.create :creator, name: 'Jessica', role: 'writer' }

    it 'response with all creators' do
      get :index, format: 'json'
      expect(assigns(:creators)).to match_array([cre_1, cre_2])
    end

    it 'renders index template' do
      get :index, {format: 'json'}
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    let(:cre_1) { FactoryGirl.create :creator }
    it 'assigns the requested creator to @creator' do
      get :show, id: cre_1, format: 'json'
      expect(assigns(:creator)).to eq cre_1
    end

    it 'renders show template' do
      get :show, id: FactoryGirl.create(:creator), format: 'json'
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryGirl.attributes_for(:creator) }

      it 'creates a new creator' do
        expect{
          post :create, creator: valid_attributes, format: :json
        }.to change(Creator, :count).by(1)
      end
    end

    context 'without valid parameters' do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_creator) }

      it 'does not save new creator' do
        expect{
          post :create, creator: invalid_attributes, format: :json
        }.to_not change(Creator, :count)
      end
    end
  end

  describe 'PATCH #update' do
    let(:cre_update) { FactoryGirl.create :creator }
    context 'with valid attributes' do
      it 'responsed with requested creator' do
        patch :update, id: cre_update, creator: FactoryGirl.attributes_for(:creator), format: :json
        expect(assigns(:creator)).to eq cre_update
      end

      it 'changes @creator attributes' do
        patch :update, id: cre_update, creator: FactoryGirl.attributes_for(:creator, name: 'Jaylen Ryan', role: 'writer'), format: :json
        cre_update.reload
        expect(cre_update.name).to eq 'Jaylen Ryan'
        expect(cre_update.role).to eq 'writer'
      end
    end

    context 'with invalid attributes' do
      it 'does not update @creator attributes' do
        patch :update, id: cre_update, creator: FactoryGirl.attributes_for(:creator, name: nil, role: nil), format: :json
        cre_update.reload
        expect(cre_update.name).to_not eq nil
        expect(cre_update.role).to_not eq nil
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:cre_delete) { FactoryGirl.create(:creator, name: 'Archive me', role: 'artist', archived: false) }

    it 'archives creator' do
      delete :destroy, id: cre_delete
      expect(cre_delete.archive).to eq true
    end
  end
end
