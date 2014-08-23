require 'spec_helper'

describe PublishersController, type: :controller do
  let(:pub) { FactoryGirl.create :publisher }

  describe 'GET #index' do
    it 'gets all the publishers' do
      pub_2 = FactoryGirl.create(:publisher, name: 'Pub_2')

      get :index, {format: 'json'}
      expect(assigns(:publishers)).to match_array([pub, pub_2])
    end

    it 'renders index template' do
      get :index, {format: 'json'}
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) { FactoryGirl.attributes_for(:publisher) }

      it 'creates a new publisher' do
        expect{
          post :create, publisher: valid_attributes, format: :json
        }.to change(Publisher, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { FactoryGirl.attributes_for(:invalid_publisher) }

      it 'does not save new publisher' do
        expect{
          post :create, publisher: invalid_attributes, format: :json
        }.to_not change(Publisher, :count)
      end
    end
  end

  describe "PATCH #update" do
    context 'with valid attributes' do
      fit 'finds the requested publisher' do
        patch :update, id: pub, publisher: FactoryGirl.attributes_for(:publisher), format: :json
        expect(assigns(:publisher)).to eq pub
      end

      it 'changes @publisher attributes' do
        patch :update, id: pub, publisher: FactoryGirl.attributes_for(:publisher, name: 'SamplePub'), format: :json
        pub.reload
        expect(pub.name).to eq 'SamplePub'
      end
    end

    context 'with invalid attributes' do
      before :each do
        patch :update, id: pub,
          publisher: FactoryGirl.attributes_for(:publisher, name: nil), format: :json
      end

      it 'does not change @publisher attributes' do
        pub.reload
        expect(pub.name).to_not eq nil
      end
    end
  end
end
