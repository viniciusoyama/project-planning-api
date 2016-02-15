require 'rails_helper'

describe 'Tasks API', type: :request do
  let(:valid_attributes) do
    {
      name: 'Viny',
      project_id: FactoryGirl.create(:project).id,
      start_at: Date.today,
      end_at: Date.tomorrow
    }
  end

  let(:invalid_attributes) do
    {
      project_id: ''
    }
  end

  describe "GET /v1/tasks" do
    it "lists all the tasks" do
      task1 = FactoryGirl.create :task
      task2 = FactoryGirl.create :task
      get "/v1/tasks", params: {}
      expect(json.count).to eq(2)
      expect(json[0]).to match_json_schema('v1/task')
      expect(json[1]).to match_json_schema('v1/task')
      expect(response.status).to eq(200)
    end
  end

  describe "GET /v1/tasks/:id" do
    it "shows the task" do
      task = FactoryGirl.create :task
      get "/v1/tasks/#{task.id}", params: { id: task.id }
      expect(response).to match_json_schema('v1/task')
      expect(response.status).to eq(200)
    end
  end

  describe "POST /v1/tasks" do
    context "with valid params" do
      it "creates a new task" do
        expect do
          post "/v1/tasks", params: { task: valid_attributes }
        end.to change(Task, :count).by(1)
      end

      it "responds with 200" do
        post "/v1/tasks", params: { task: valid_attributes }
        expect(response.status).to eq(201)
      end
    end

    context "with invalid params" do
      it "respond with error" do
        post "/v1/tasks", params: { task: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /v1/tasks/:id" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: 'editado'
        }
      end

      it "updates the requested task" do
        task = FactoryGirl.create :task
        put "/v1/tasks/#{task.id}", params: { id: task.to_param, task: new_attributes }
        task.reload
        expect(task.name).to eq('editado')
        expect(response.status).to eq(200)
      end

    end

    context "with invalid params" do
      it "respond with error" do
        task = FactoryGirl.create :task
        put "/v1/tasks/#{task.id}", params: { id: task.to_param, task: invalid_attributes }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE /v1/tasks/:id" do
    it "destroys the requested task" do
      task = FactoryGirl.create :task
      expect do
        delete "/v1/tasks/#{task.id}", params: { id: task.to_param }
      end.to change(Task, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end

end
