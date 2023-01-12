class Admin::HomesController < ApplicationController
  # 管理者ログインしているなら
  before_action :admin_match?

  def top
    @customers = Customer.page(params[:page])
  end
end
