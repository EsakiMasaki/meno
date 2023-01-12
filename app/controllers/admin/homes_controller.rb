class Admin::HomesController < ApplicationController
  before_action :admin_match?

  def top
    @customers = Customer.page(params[:page])
  end
end
