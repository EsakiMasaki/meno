class Admin::CustomersController < ApplicationController
  # 管理者ログインしているなら
  before_action :admin_match?

  def show
    @notes = Note.all
    @customer = Customer.find(params[:id])
    @categories = @customer.categories.all.order(:name)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.name}の会員ステータスを\n編集しました"
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
