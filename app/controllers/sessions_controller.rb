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
      # 7. 3 チェックボックスを追加しよう
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
      # 7. 1. 3 rememberヘルパーメソッドを作ってlog_inヘルパーメソッドと連携
      # 8. 3redirect_back_orの引数にuserを指定することで、デフォルトのURLを設定
      # redirect_to user
    else
      flash.now[:danger] = '認証に失敗しました。' # エラーメッセージ用のflash
      #flash.nowではレンダリングが終わっているページでフラッシュメッセージを表示することができます。つまり、「リダイレクトはしないがフラッシュを表示したい」時に使えます
      render :new
    end
  end
  
  # 6. 6 ログアウト機能を追加しよう
  def destroy
    # 7. 2 ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end
