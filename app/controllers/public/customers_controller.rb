class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
  # url直接入力対策
  before_action :current_customer_match?, only: [:edit,:update]
  before_action :ensure_guest_user, only: [:edit,:update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    #コントローラー側で一度読み込んでおく
    @customer.get_profile_image(50,50)
    @category = @customer.categories.new
    @categories = @customer.categories.all.order(:name)
    #カテゴリーidがnilのノートを見つける
    notes = @customer.notes.all.order(:title)
    note_category_nil = []
    notes.each do |note|
     if (note.category_id == nil) || (note.category == nil)
       note_category_nil.push(note)
     end
    end
    @notes = note_category_nil
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

  # ゲストの時、url直接入力対策
  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.name == "ゲスト"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません"
      redirect_to customer_path(current_customer)
    end
  end
end
