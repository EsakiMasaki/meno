class Public::CategoriesController < ApplicationController
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
    category = current_customer.categories.find(params[:id])
    category.update(category_params)
    redirect_to customer_path(current_customer)
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
