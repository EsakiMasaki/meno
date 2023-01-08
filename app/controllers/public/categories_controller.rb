class Public::CategoriesController < ApplicationController
  def create
    category = current_customer.categories.new(category_params)
    category.save
    redirect_to request.referer
  end

  def destroy
    category = current_customer.categories.find(params[:id])
    category.destroy
    redirect_to request.referer
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
