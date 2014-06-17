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

  describe 'GET #new' do
    it 'assigns a new publisher to @publisher' do
      get :new
      expect(assigns(:publisher)).to be_a_new(Publisher)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
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
  
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryGirl.attributes_for(:publisher) }

      it 'save new publisher' do
        expect{
          post :create, publisher: valid_attributes
        }.to change(Publisher, :count).by(1)
      end

      it 'redirects to publisher#index' do
        post :create, publisher: valid_attributes
        expect(response).to redirect_to(publishers_path)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_publisher) }

      it 'does not save new publisher' do
        expect{
          post :create, publisher: invalid_attributes
        }.to_not change(Publisher, :count)
      end

      it 're-renders the :new template' do
        post :create, publisher: invalid_attributes
        expect(response).to render_template :new
      end
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

    context 'with invalid attributes' do
      before :each do
        patch :update, id: pub,
          publisher: FactoryGirl.attributes_for(:publisher, name: nil)
      end

      it 'does not change @publisher attributes' do
        pub.reload
        expect(pub.name).to_not eq nil
      end

      it 'redirects to index' do
        expect(response).to render_template :edit
      end
    end
  end
end