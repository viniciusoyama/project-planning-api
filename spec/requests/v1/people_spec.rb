require 'rails_helper'

describe 'People API', type: :request do
  let(:valid_attributes) do
    {
      name: 'Viny',
      email: 'viny@email.com',
      job_title: 'Developer Jr'
    }
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  describe "GET /v1/people" do
    it "lists all the people" do
      person1 = FactoryGirl.create :person
      person2 = FactoryGirl.create :person
      get '/v1/people', params: {}
      expect(json.count).to eq(2)
      expect(json[0]).to match_json_schema('v1/person')
      expect(json[1]).to match_json_schema('v1/person')
      expect(response.status).to eq(200)
    end
  end

  describe "GET /person/:id" do
    it "shows the person" do
      person = FactoryGirl.create :person
      get "/v1/people/#{person.id}", params: { id: person.id }
      expect(response).to match_json_schema('v1/person')
      expect(response.status).to eq(200)
    end
  end

  describe "POST /v1/people" do
    context "with valid params" do
      it "creates a new person" do
        expect do
          post '/v1/people', params: { person: valid_attributes }
        end.to change(Person, :count).by(1)
      end

      it "responds with 200" do
        post '/v1/people', params: { person: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post '/v1/people', params: { person: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /v1/people/:id" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: 'editado'
        }
      end

      it "updates the requested person" do
        person = FactoryGirl.create :person
        put "/v1/people/#{person.id}", params: { id: person.to_param, person: new_attributes }
        person.reload
        expect(person.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        person = FactoryGirl.create :person
        put "/v1/people/#{person.id}", params: { id: person.to_param, person: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /v1/people/:id" do
    it "destroys the requested person" do
      person = FactoryGirl.create :person

      expect do
        delete "/v1/people/#{person.id}", params: { id: person.to_param }
      end.to change(Person, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end

end
