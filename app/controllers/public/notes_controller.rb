class Public::NotesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]
  # url直接入力対策
  before_action :current_customer_match?, only: [:edit,:update,:destroy]

  def new
    @note = Note.new
    # buildで子モデルのインスタンス作成
    @procedures = @note.note_procedures.build
  end

  def create
    @note = current_customer.notes.new(note_params)
    if @note.save
      flash[:notice] = "ノートを作成しました"
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def index
    @notes = current_customer.notes.page(params[:page]).order(created_at: :desc)
    @notes.each do |note|
      # ノートに存在しないカテゴリーidがあれば、カテゴリーidをnilにする
      unless Category.exists?(id: note.category_id)
        note.category_id = nil
      end
    end
  end

  def show
    @comment = NoteComment.new
    @comments = NoteComment.all
    @note = Note.find(params[:id])
    # ノートに存在しないカテゴリーidがあれば、カテゴリーidをnilにする
    unless Category.exists?(id: @note.category_id)
      @note.category_id = nil
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = current_customer.notes.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "ノートを編集しました"
      redirect_to note_path(@note)
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = "ノートを削除しました"
      redirect_to notes_path
    else
      render :show
    end
  end

  private

  # ストロングパラメータに子モデルのパラメータも入れる
  def note_params
    params.require(:note).permit(:title,:can,:necessities,:conclude,:category_id,:publish_status,note_procedures_attributes: [:id,:procedure,:explanation,:procedure_image,:_destroy])
  end

  # url直接入力対策
  def current_customer_match?
    note = Note.find(params[:id])
    unless current_customer == note.customer
      redirect_to root_path
    end
  end
end
