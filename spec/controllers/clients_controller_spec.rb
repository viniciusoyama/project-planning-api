require 'rails_helper'

describe ClientsController, type: :controller do  
  let(:valid_attributes) do
    {
      name: 'Viny'
    }
  end

  let(:invalid_attributes) do 
    {
      name: ''
    } 
  end

  describe "GET #index" do
    it "lists all the clients" do
      client1 = FactoryGirl.create :client
      client2 = FactoryGirl.create :client
      get :index, params: {}
      expect(JSON.parse(response.body).count).to eq(2)
      expect(response.status).to eq(200)
    end
  end

  describe "GET #show" do
    it "shows the client" do
      client = FactoryGirl.create :client
      get :show, params: { id: client.id }
      expect(JSON.parse(response.body)['name']).to eq(client.name)
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Client" do
        expect do
          post :create, params: { client: valid_attributes }
        end.to change(Client, :count).by(1)
      end

      it "responds with 200" do
        post :create, params: { client: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post :create, params: { client: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: 'editado'
        }
      end

      it "updates the requested client" do
        client = FactoryGirl.create :client
        put :update, params: { id: client.to_param, client: new_attributes }
        client.reload
        expect(client.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        client = FactoryGirl.create :client
        put :update, params: { id: client.to_param, client: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect do
        delete :destroy, params: { id: client.to_param }
      end.to change(Client, :count).by(-1)
      expect(response.status).to eq(204)  
    end
  end

end
