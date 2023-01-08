class Public::HomesController < ApplicationController
  def top
    @notes = Note.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    @notes.each do |note|
      unless Category.exists?(id: note.category_id)
        note.category_id = nil
      end
    end
  end

  def about
  end
end
