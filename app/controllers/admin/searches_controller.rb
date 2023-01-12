class Admin::SearchesController < ApplicationController
  before_action :admin_match?

  def search
    @word = params[:word]
    @customers = Customer.looks(@word)
    render "/admin/searches/customer_search_index"
  end
end
