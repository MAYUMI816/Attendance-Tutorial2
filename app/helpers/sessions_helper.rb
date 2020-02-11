# 6. 3. 1 ログイン用のメソッドを作ろう
module SessionsHelper

  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id 
    #このコードを実行すると、ユーザーのブラウザ内にある一時的cookiesに暗号化済みのuser.idが自動で生成されます。
  end
  
  # 7. 1. 3永続的セッションを記憶します（Userモデルを参照）
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
   # 7. 1. 4永続的セッションを破棄します
  def forget(user)
    user.forget # Userモデル参照
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
    # 6. 6 ログアウト機能を追加しよう セッションと@current_userを破棄します
  def log_out
    forget(current_user) #7. 1. 4
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 6. 3. 2 current_userを定義しよう
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  # 7. 1. 3一時的セッションにいるユーザーを返します。
  # 7. 1. 3それ以外の場合はcookiesに対応するユーザーを返します。
  def current_user
    if (user_id = session[:user_id]) # session[:user_id]
       @current_user ||= User.find_by(id: user_id)# @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
    # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_user.nil?
  end
end