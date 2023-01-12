class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def index
    @customers = Customer.page(params[:page])
  end

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
      flash[:notice] = "プロフィールを編集しました"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:name,:introduction,:profile_image)
  end
end
