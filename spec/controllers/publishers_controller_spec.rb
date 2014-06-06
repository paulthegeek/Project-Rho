require 'spec_helper'

describe PublishersController do
  let(:pub) { FactoryGirl.create :publisher }

  describe 'GET #index' do
    it 'gets all the publishers' do
      pub_2 = FactoryGirl.create(:publisher, name: 'Pub_2')

      get :index
      expect(assigns(:publishers)).to match_array([pub, pub_2])
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #edit" do
    it 'finds the requested publisher' do
      get :edit, id: pub
      expect(assigns(:publisher)).to eq pub
    end

    fit 'renders edit template' do
      get :edit, id: pub
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    context 'with valid attributes' do
      it 'finds the requested publisher' do
        patch :update, id: pub, publisher: FactoryGirl.attributes_for(:publisher)
        expect(assigns(:publisher)).to eq pub
      end

      it 'changes @publisher attributes' do
        patch :update, id: pub, publisher: FactoryGirl.attributes_for(:publisher, name: 'Marvel')
        pub.reload
        expect(pub.name).to eq 'Marvel'
      end

      it 'redirects to index' do
        patch :update, id: pub, publisher: FactoryGirl.attributes_for(:publisher)
        expect(response).to redirect_to(publishers_path)
      end
    end
  end
end