class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def show
    @category = Category.find(params[:id])
  end

  def create
    category = current_customer.categories.new(category_params)
    category.save
    redirect_to request.referer
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = current_customer.categories.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリー名を編集しました"
      redirect_to customer_path(current_customer)
    else
      render :edit
    end
  end

  def destroy
    category = current_customer.categories.find(params[:id])
    category.destroy
    redirect_to customer_path(current_customer)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
