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
  end

  def show
  end

  def edit
  end
  
  private

  def note_params
    params.require(:note).permit(:title,:can,:necessities,:conclude,:category_id,:publish_status,texts_attributes: [:id,:procedure,:explanation,:procedure_image,:_destroy])
  end
end
