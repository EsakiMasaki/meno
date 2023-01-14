class Public::CategoriesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
  # url直接入力対策
  before_action :current_customer_match?, only: [:edit,:update,:destrooy]

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
    flash[:notice] = "カテゴリー名を削除しました"
    redirect_to customer_path(current_customer)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  # url直接入力対策
  def current_customer_match?
    category = Category.find(params[:id])
    unless current_customer == category.customer
      redirect_to root_path
    end
  end
end
