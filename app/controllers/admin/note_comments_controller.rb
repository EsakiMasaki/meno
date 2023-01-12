class Admin::NoteCommentsController < ApplicationController
  before_action :admin_match?

  def destroy
    @note = Note.find(params[:note_id])
    NoteComment.find(params[:id]).destroy
  end
end
