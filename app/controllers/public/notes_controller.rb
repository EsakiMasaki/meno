class Public::NotesController < ApplicationController
  def new
    @note = Note.new
    @procedures = @note.note_procedures.build
  end

  def create
    @note = current_customer.notes.new(note_params)
    if @note.save
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def index
    @notes = current_customer.notes.all.order(created_at: :desc)
    @notes.each do |note|
      unless Category.exists?(id: note.category_id)
        note.category_id = nil
      end
    end
  end

  def show
    @comment = NoteComment.new
    @comments = NoteComment.all
    @note = Note.find(params[:id])
    unless Category.exists?(id: @note.category_id)
      @note.category_id = nil
    end
  end

  def edit
  end

  private

  def note_params
    params.require(:note).permit(:title,:can,:necessities,:conclude,:category_id,:publish_status,note_procedures_attributes: [:id,:procedure,:explanation,:procedure_image,:_destroy])
  end
end
