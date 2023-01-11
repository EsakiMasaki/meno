class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

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
