class Admin::NoteCommentsController < ApplicationController
  def destroy
    @note = Note.find(params[:note_id])
    NoteComment.find(params[:id]).destroy
  end
end
