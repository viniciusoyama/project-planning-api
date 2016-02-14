require 'rails_helper'

describe 'Projects API', type: :request do
  let(:valid_attributes) do
    {
      name: 'Viny',
      client_id: FactoryGirl.create(:client).id
    }
  end

  let(:invalid_attributes) do
    {
      name: ''
    }
  end

  describe "GET /v1/projects" do
    it "lists all the projects" do
      project1 = FactoryGirl.create :project
      project2 = FactoryGirl.create :project
      get "/v1/projects", params: {}

      expect(json.count).to eq(2)
      expect(json[0]['name']).to eq(project1.name)
      expect(json[0]['description']).to eq(project1.description)
      expect(json[1]['name']).to eq(project2.name)
      expect(json[1]['description']).to eq(project2.description)
      expect(response.status).to eq(200)
    end
  end

  describe "GET /v1/projects/:id" do
    it "shows the project" do
      project = FactoryGirl.create :project
      get "/v1/projects/#{project.id}", params: { id: project.id }
      expect(JSON.parse(response.body)['name']).to eq(project.name)
      expect(response.status).to eq(200)
    end
  end

  describe "POST /v1/projects" do
    context "with valid params" do
      it "creates a new project" do
        expect do
          post "/v1/projects", params: { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it "responds with 200" do
        post "/v1/projects", params: { project: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post "/v1/projects", params: { project: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /v1/projects/:id" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: 'editado'
        }
      end

      it "updates the requested project" do
        project = FactoryGirl.create :project
        put "/v1/projects/#{project.id}", params: { id: project.to_param, project: new_attributes }
        project.reload
        expect(project.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        project = FactoryGirl.create :project
        put "/v1/projects/#{project.id}", params: { id: project.to_param, project: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /v1/projects/:id" do
    it "destroys the requested project" do
      project = FactoryGirl.create :project
      expect do
        delete "/v1/projects/#{project.id}", params: { id: project.to_param }
      end.to change(Project, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end

end
