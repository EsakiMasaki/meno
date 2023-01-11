class Admin::CustomersController < ApplicationController
  before_action :admin_match?

  def show
    @customer = Customer.find(params[:id])
    @category = @customer.categories.new
    @categories = @customer.categories.all.order(:name)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.name}の会員ステータスを編集しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end
end
