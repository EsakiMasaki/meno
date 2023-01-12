class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def search
    @word = params[:word]
    if params[:customer_search]
      @customers = Customer.looks(@word).page(params[:page])
      render "/public/searches/customer_search_index"
    elsif params[:note_search]
      notes = Note.looks(@word)
      publish_notes = []
      notes.each do |note|
        if note.publish_status == "publish"
          publish_notes.push(note)
        end
      end
      @notes = Kaminari.paginate_array(publish_notes).page(params[:page])

      categories = Category.looks(@word)
      publish_categories = []
      categories.each do |category|
        category.notes.each do |note|
          if note.publish_status == "publish"
            publish_categories.push(note)
          end
        end
      end
      @categories = Kaminari.paginate_array(publish_categories).page(params[:page])
      render "/public/searches/note_search_index"
    end
  end
end
