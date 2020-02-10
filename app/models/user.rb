class User < ApplicationRecord
  
  before_save { self.email = email.downcase } 
  #（self.email）の値をdowncaseメソッドを使って小文字に変換します。
  
  validates :name,  presence: true, length: { maximum: 50 } #name 存在性/最大50文字まで
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # 4. 4. 4 メールアドレスの有効性を検証
  validates :email, presence: true, length: { maximum: 100 }, #email存在性/最大100文字まで/正規表現によるメールアドレスのフォーマット/一意であること
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true # 4. 4. 5 一意性の検証                   
has_secure_password
# 4. 5 Userモデルにpassword_digestカラムを追加し、bcryptgemを追加したしたことでhas_secure_passwordが使用できるように
validates :password, presence: true, length: { minimum: 6 } #password/存在性/最小6文字から
#4. 5. 1 最小文字数を設定しよう
end