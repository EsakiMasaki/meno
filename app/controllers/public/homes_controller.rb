class Public::HomesController < ApplicationController
  before_action :authenticate_customer!, except: [:top,:about,:show,:search]

  def top
    # sortでいいね順に並べる
    @notes = Note.includes(:favorited_customers).sort {|a,b| b.favorited_customers.size <=> a.favorited_customers.size}
    @notes.each do |note|
      # ノートに存在しないカテゴリーidがあれば、カテゴリーidをnilにする
      unless Category.exists?(id: note.category_id)
        note.category_id = nil
      end
    end
  end

  def about
  end
end
