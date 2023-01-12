class Admin::NotesController < ApplicationController
  # 管理者ログインしているなら
  before_action :admin_match?

  def show
    @comment = NoteComment.new
    @comments = NoteComment.all
    @note = Note.find(params[:id])
    # ノートに存在しないカテゴリーidがあれば、カテゴリーidをnilにする
    unless Category.exists?(id: @note.category_id)
      @note.category_id = nil
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to admin_customer_path(note.customer)
  end
end
