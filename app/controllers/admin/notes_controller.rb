class Admin::NotesController < ApplicationController
  def show
    @comment = NoteComment.new
    @comments = NoteComment.all
    @note = Note.find(params[:id])
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
