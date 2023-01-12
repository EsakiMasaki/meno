class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def create
    relationship = current_customer.relationships.new(followed_id: params[:customer_id])
    relationship.save
    redirect_to request.referer
  end

  def destroy
    relationship = current_customer.relationships.find_by(followed_id: params[:customer_id])
    relationship.destroy
    redirect_to request.referer
  end

  def followers
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followers.page(params[:page])
  end

  def followings
    @customer = Customer.find(params[:customer_id])
    @customers = @customer.followings.page(params[:page])
  end
end
