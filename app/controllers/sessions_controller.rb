class SessionsController < ApplicationController
  def new
  end
  
  
  # 6. 2. 2 ユーザーの検索と認証
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #  downcaseメソッドを呼び出すことで、入力したメールアドレスは全て小文字として判定されます。
    if user && user.authenticate(params[:session][:password])
     # &&は取得したユーザーオブジェクトが有効か判定するために使用
      # 6. 3. 1ログイン後にユーザー情報ページにリダイレクトします。
      log_in user
      redirect_to user
    else
      # ここにはエラーメッセージ用のflashを入れます。
      flash.now[:danger] = '認証に失敗しました。' 
      #flash.nowではレンダリングが終わっているページでフラッシュメッセージを表示することができます。つまり、「リダイレクトはしないがフラッシュを表示したい」時に使えます
      render :new
    end
  end
  
  # 6. 6 ログアウト機能を追加しよう
  def destroy
    log_out
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
  
end
