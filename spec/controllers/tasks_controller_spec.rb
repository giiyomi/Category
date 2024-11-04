require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  render_views
  fixtures :users, :categories, :tasks
  
  before do
    @user = users(:one)
    sign_in @user
    @category = categories(:one)
    @task_one = tasks(:task_one)
    @task_two = tasks(:task_two)
    @task_three = tasks(:task_three)
  end

  describe "tasks#index ROUTE/ GET" do
    context "SHOW All Tasks in SPECIFIC Category" do
      it "returns corresponding TASKS" do
        get :index, params: { category_id: @category.id }
        expect(response).to have_http_status(200)
        expect(response.body).to include(@task_one.due_date.to_s, @task_one.details)
      end
    end
  end

  describe "tasks#create ROUTE/ POST" do
    context "CREATE new task SUCCESSFULLY" do

      it "increases the TASK Count by 1, sign of succesfull creation" do
        expect { post :create, params: { category_id: @category.id, task: { details: "New Task", due_date: Date.today, category_id: @category.id } }
        }.to change(Task, :count).by(1)
      end

      it "goes to the tasks#index after a valid creation" do
        post :create, params: { category_id: @category.id, task: { details: "New Task", due_date: Date.today, category_id: @category.id } }
        expect(response).to redirect_to(category_tasks_path(@category))
      end

      it "appears either successful or fail status" do
        post :create, params: { category_id: @category.id, task: { details: "New Task", due_date: Date.today, category_id: @category.id } }
        expect(flash[:notice]).to eq('Task was successfully created.')
      end
    end

    context "CREATE new task FAILS" do
      it "does NOT increase the TASK Count, sign of failed creation" do
        expect {
          post :create, params: { category_id: @category.id, task: { details: nil, due_date: Date.today, category_id: @category.id } }
        }.not_to change(Task, :count)
      end

      it "does NOT route to the tasks#index after AN ATTEMPT" do
        post :create, params: { category_id: @category.id, task: { details: nil, due_date: Date.today, category_id: @category.id } }
        expect(response).not_to redirect_to(category_tasks_path(@category))
      end

      it "shows unprocessable_entity status" do
        post :create, params: { category_id: @category.id, task: { details: nil, due_date: Date.today, category_id: @category.id } }
        expect(response).to have_http_status(422)
      end
    end
    
  end

end
