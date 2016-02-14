require 'rails_helper'

describe 'Clients API', type: :request do  
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

  describe "GET /clients" do
    it "lists all the clients" do
      client1 = FactoryGirl.create :client
      client2 = FactoryGirl.create :client
      get '/clients', params: {}
      expect(json.count).to eq(2)
      expect(json[0]['name']).to eq(client1.name)
      expect(json[1]['name']).to eq(client2.name)
      expect(response.status).to eq(200)
    end
  end

  describe "GET /client/:id" do
    it "shows the client" do
      client = FactoryGirl.create :client
      get "/clients/#{client.id}", params: { id: client.id }
      expect(response).to match_json_schema('v1/client')
      expect(response.status).to eq(200)
    end
  end

  describe "POST /clients" do
    context "with valid params" do
      it "creates a new Client" do
        expect do
          post '/clients', params: { client: valid_attributes }
        end.to change(Client, :count).by(1)
      end

      it "responds with 200" do
        post '/clients', params: { client: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post '/clients', params: { client: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /clients/:id" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: 'editado'
        }
      end

      it "updates the requested client" do
        client = FactoryGirl.create :client
        put "/clients/#{client.id}", params: { id: client.to_param, client: new_attributes }
        client.reload
        expect(client.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        client = FactoryGirl.create :client
        put "/clients/#{client.id}", params: { id: client.to_param, client: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /clients/:id" do
    it "destroys the requested client" do
      client = Client.create! valid_attributes
      expect do
        delete "/clients/#{client.id}", params: { id: client.to_param }
      end.to change(Client, :count).by(-1)
      expect(response.status).to eq(204)  
    end
  end

end
