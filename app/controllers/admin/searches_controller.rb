class Admin::SearchesController < ApplicationController
  # 管理者ログインしているなら
  before_action :admin_match?

  def search
    @word = params[:word]
    @customers = Customer.looks(@word).page(params[:page])
    render "/admin/searches/customer_search_index"
  end
end
