class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def search
    @word = params[:word]

    # submitボタンのnameがcustomer_searchの時(ユーザー検索)
    if params[:customer_search]
      # ユーザー検索
      @customers = Customer.looks(@word).page(params[:page])
      render "/public/searches/customer_search_index"

    # submitボタンのnameがnote_searchの時(ノート検索、カテゴリー検索)
    elsif params[:note_search]
      # ノート検索
      notes = Note.looks(@word)
      publish_notes = []
      notes.each do |note|
        # 検索したものの中から公開ステータスが公開のものを配列に追加する
        if note.publish_status == "publish"
          publish_notes.push(note)
        end
      end
      @notes = Kaminari.paginate_array(publish_notes).page(params[:page])

      # カテゴリー検索
      categories = Category.looks(@word)
      publish_categories = []
      categories.each do |category|
        category.notes.each do |note|
          # 検索したものの中から公開ステータスが公開のものを配列に追加する
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
