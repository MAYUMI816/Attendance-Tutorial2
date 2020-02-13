# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true) #8. 5. 1 管理権限属性を追加 最初のユーザーだけadmin属性をtrueに設定

60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
# 8. 4. 1 サンプルユーザーをたくさん作ろう
# このスクリプトが生成されると、合計61件のサンプルユーザーが生成されます。
#スクリプトはrails db:seedで実行可能
