class UsersController < ApplicationController
  # 8. 2. 1 ユーザーにログインを要求する
  before_action :set_user, only: [:show, :edit, :update] # 8. 2. 2
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update] # 8. 2. 2
  
  # 8. 4 全てのユーザーを表示するページ
  def index
    @users = User.all
  end
  
  def show
    # @user = User.find(params[:id]) # 5. 2findメソッドを使ってユーザーオブジェクトを取得し、インスタンス変数に代入
  # 8. 2. 2で削除
  end
  
  def new
    @user = User.new # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
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
  
# 8. 1 ユーザー編集ページを作ろう  
  def edit # ユーザー情報編集ページ
    # @user = User.find(params[:id]) # 8. 2. 2で削除
  end
# 8. 1. 2 更新に失敗した場合の処理  
  def update
    # @user = User.find(params[:id]) # 8. 2. 2で削除
    if @user.update_attributes(user_params)
 # 8. 1. 3更新に成功した場合の処理を記述します。
    flash[:success] = "ユーザー情報を更新しました。"
    redirect_to @user
    else
      render :edit      
    end
  end
  
  private
# Web経由で外部のユーザーが知る必要は無いため、次に記すようにRubyのprivateキーワードを用いて外部からは使用できないようにします。
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
   
       # beforeフィルター

 #8. 2. 2 paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
    
    # 8. 2. 1 ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location # 8. 3
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
        # 8. 2. 2 アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      # @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end
end
