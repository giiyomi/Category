class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category
  before_action :get_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = @category.tasks
  end

  def tasks_for_today
    @tasks_today = Task.all
  end

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)
    if @task.save
      redirect_to category_tasks_path(@category), notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(@category), notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@category), notice: 'Task was successfully deleted.'
  end
  
  private

  def get_category
    @category = Category.find(params[:category_id])
  end

  def get_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:details, :category_id, :due_date)
  end
end
