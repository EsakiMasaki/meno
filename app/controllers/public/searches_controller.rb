class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    if params[:customer_search]
      @customers = Customer.looks(@word)
      render "/public/searches/customer_search_index"
    elsif params[:note_search]
      @notes = Note.looks(@word)
      @categories = Category.looks(@word)
      render "/public/searches/note_search_index"
    end
  end
end
