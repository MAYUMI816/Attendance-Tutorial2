class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id]) 
    # 5. 2findメソッドを使ってユーザーオブジェクトを取得し、インスタンス変数に代入
    
  end
  
  def new
    @user = User.new 
    # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
# 5. 5. 2 まずは登録の失敗に対応しよう
  def create
   # @user = User.new(params[:user]) ↓書き換え
    @user = User.new(user_params)
    if @user.save
      log_in @user # 6.5保存成功後、ログインします。
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      flash[:success] = '新規作成に成功しました。' # 5. 5. 6 サクセスメッセージを表示しよう
      redirect_to @user # 5. 5. 5 ユーザーを保存しよう
    else
      render :new
    end
  end
  
  
  private
# Web経由で外部のユーザーが知る必要は無いため、次に記すようにRubyのprivateキーワードを用いて外部からは使用できないようにします。
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
