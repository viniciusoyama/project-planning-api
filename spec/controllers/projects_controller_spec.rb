require 'rails_helper'

describe ProjectsController, type: :controller do  
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

  describe "GET #index" do
    it "lists all the projects" do
      project1 = FactoryGirl.create :project
      project2 = FactoryGirl.create :project
      get :index, {}
      expect(JSON.parse(response.body).count).to eq(2)
      expect(response.status).to eq(200)
    end
  end

  describe "GET #show" do
    it "shows the project" do
      project = FactoryGirl.create :project
      get :show, { id: project.id }
      expect(JSON.parse(response.body)['name']).to eq(project.name)
      expect(response.status).to eq(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new project" do
        expect do
          post :create, { project: valid_attributes }
        end.to change(Project, :count).by(1)
      end

      it "responds with 200" do
        post :create, { project: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post :create, { project: invalid_attributes }
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

      it "updates the requested project" do
        project = FactoryGirl.create :project
        put :update, { id: project.to_param, project: new_attributes }
        project.reload
        expect(project.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        project = FactoryGirl.create :project
        put :update, { id: project.to_param, project: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested project" do
      project = FactoryGirl.create :project
      expect do
        delete :destroy, { id: project.to_param }
      end.to change(Project, :count).by(-1)
      expect(response.status).to eq(204)  
    end
  end

end
