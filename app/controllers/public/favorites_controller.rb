class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def create
    note = Note.find(params[:note_id])
    @favorite = current_customer.favorites.new(note_id: note.id)
    @favorite.save
  end

  def destroy
    note = Note.find(params[:note_id])
    @favorite = current_customer.favorites.find_by(note_id: note.id)
    @favorite.destroy
  end

  def favorite
    @favorites = current_customer.favorites.order(created_at: :desc)
  end
end
