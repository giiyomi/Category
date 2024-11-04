require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
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

  describe "categories#index ROUTE/ GET" do
    context "SHOW All Categories" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "categories#show ROUTE/ GET" do
    context "SHOW category" do
      it "returns selected category" do
        get :show, params: { id: @category.id }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "categories#create ROUTE/ POST" do
    context "Successful CREATE" do
      it "creates a new category" do
        expect {
          post :create, params: { category: { name: "Uniqueness", description: "Sample" } }
        }.to change(Category, :count).by(1)
      end

      it "redirects to the newly created category" do
        post :create, params: { category: { name: "Uniqueness", description: "Sample" } }
        expect(response).to redirect_to(Category.last)
      end
    end

    context "Unsuccessful CREATE" do
      it "w/Blank or Empty NAME" do
        expect {
          post :create, params: { category: { name: "", description: "Sample" } }
        }.not_to change(Category, :count)
      end

      it "re-renders the new template" do
        post :create, params: { category: { name: "", description: "Sample" } }
        expect(response).to render_template(:new)
      end      
    end
  end

  describe "categories#edit ROUTE/ PUT OR PATCH" do
    context "Successful Update" do
      it "updates the category" do
        put :update, params: { id: @category.id, category: { name: "Updated Name", description: "Updated Description" } }
        @category.reload
        expect(@category.name).to eq("Updated Name")
        expect(@category.description).to eq("Updated Description")
        expect(response).to redirect_to(@category)
        expect(flash[:notice]).to eq("Category was successfully updated.")
      end
    end
  end

  describe "categories#tasks_for_today ROUTE/ GET" do
    context "SHOW All Tasks INSIDE All Categories Folder" do
      it "shows ALL TASKS from different CATEGORIES" do
        get :tasks_for_today
        expect(response).to have_http_status(200)
      end
    end
  end
end
