class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)#フォームから送信されたcontent内容を取得
        @micropost.image.attach(params[:micropost][:image])
        if @micropost.save#この処理でidやcreated_at, updated_atが自動で生成される
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed.paginate(page: params[:page])
            render "static_pages/home", status: :unprocessable_entity
        end
    end

    def destroy
        @micropost.destroy#単純にモデルのdestroyメソッドを使う
        flash[:success] = "Micropost deleted"
        redirect_back_or_to(root_url, status: :see_other)#redirect_back_or_toはSessionsHelperに定義されている
    end

    private
        def micropost_params
            params.require(:micropost).permit(:content, :image)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url, status: :see_other if @micropost.nil?
        end
end
