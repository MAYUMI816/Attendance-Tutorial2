# 6. 3. 1 ログイン用のメソッドを作ろう
module SessionsHelper

  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id 
    #このコードを実行すると、ユーザーのブラウザ内にある一時的cookiesに暗号化済みのuser.idが自動で生成されます。
  end
  
    # 6. 6 ログアウト機能を追加しよう セッションと@current_userを破棄します
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # 6. 3. 2 current_userを定義しよう
  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  
    # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
  def logged_in?
    !current_user.nil?
  end
end