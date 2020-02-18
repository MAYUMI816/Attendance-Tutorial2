class User < ApplicationRecord
# 7. 1. 2 「remember_token」という仮想の属性を作成します。
  attr_accessor :remember_token
  before_save { self.email = email.downcase } 
  #（self.email）の値をdowncaseメソッドを使って小文字に変換します。
  
  validates :name,  presence: true, length: { maximum: 50 } #name 存在性/最大50文字まで
  # 8. 1. 4 パスワードはスルーして更新できるようにする
  # 9.2.1validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # 4. 4. 4 メールアドレスの有効性を検証
  validates :email, presence: true, length: { maximum: 100 }, #email存在性/最大100文字まで/正規表現によるメールアドレスのフォーマット/一意であること
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true # 4. 4. 5 一意性の検証     
validates :department, length: { in: 2..50 }, allow_blank: true #9. 1. 1 バリデーションを設定しよう                    
validates :basic_time, presence: true #9.2.1
validates :work_time, presence: true #9.2.1
has_secure_password
# 4. 5 Userモデルにpassword_digestカラムを追加し、bcryptgemを追加したしたことでhas_secure_passwordが使用できるように
validates :password, presence: true, length: { minimum: 6 } , allow_nil: true#password/存在性/最小6文字から
#4. 5. 1 最小文字数を設定しよう

# 渡された文字列のハッシュ値を返します。7. 1. 1 ランダムな文字列を作ろう
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返します。7. 1. 1 ランダムな文字列を作ろう
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します。7. 1. 2 rememberメソッドを作ろう
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返します。7. 1. 3 ログイン状態の永続的保持
  def authenticated?(remember_token) # 永続化セッション）処理の準備はOK
    # 7.2ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token) # rememberヘルパーメソッドを作ってlog_inヘルパーメソッドと連携
  end
  
    # 7. 1. 4 ユーザーの記憶を忘れるユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
end
