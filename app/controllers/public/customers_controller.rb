class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
  # url直接入力対策
  before_action :current_customer_match?, only: [:edit,:update]

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
  
  # url直接入力対策
  def current_customer_match?
    customer = Customer.find(params[:id])
    unless current_customer == customer
      redirect_to root_path
    end
  end
end
