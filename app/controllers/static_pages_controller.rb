class StaticPagesController < ApplicationController
  def home#ログイン状態でホームにアクセスするとマイクロポストオブジェクトを１つ作る
    if logged_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
      #userモデルに定義したfeedメソッドを使って、current_userのマイクロポストを取得
      #@feed_itemsはマイクロポストの配列
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
