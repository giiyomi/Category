class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[ show edit update ]

  def index
    @categories = current_user.categories.all
  end

  def tasks_for_today
    @alltasks = Task.where(due_date: Date.today)
  end

  def  new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = current_user.categories.new(category_params)

    respond_to do |format|
      if @category.save
          current_user.categories << @category
          format.html { redirect_to category_url(@category), notice: "Category was successfully added"}
      else
          format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Category was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
