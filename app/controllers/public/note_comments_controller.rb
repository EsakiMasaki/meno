class Public::NoteCommentsController < ApplicationController
  def create
    @note = Note.find(params[:note_id])
    comment = current_customer.note_comments.new(note_comment_params)
    comment.note_id = @note.id
    comment.save
  end

  def destroy
    @note = Note.find(params[:note_id])
    NoteComment.find(params[:id]).destroy
  end

  private

  def note_comment_params
    params.require(:note_comment).permit(:comment,:post_status)
  end
end
