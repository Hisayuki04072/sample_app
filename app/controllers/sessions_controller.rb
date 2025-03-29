class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])#正しいパスワードと有効なユーザのみ
      reset_session#セッションハイジャックを防ぐためにセッションをリセット
      log_in user
      redirect_to user
    else
      flash.now[:danger] = "Invalid email/password combination"
      render "new", status: :unprocessable_entity#ここでのstatus:の意味は？
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
