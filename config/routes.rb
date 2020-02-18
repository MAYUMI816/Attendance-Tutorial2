Rails.application.routes.draw do
   

  #get 'static_pages/top'
  root 'static_pages#top' #get 'static_pages/top'　URL/static_pages/topから〜comで表示　
  get '/signup', to: 'users#new'# . 5. 2 ユーザールーティングの設定
  # 9.3 削除resources :users # 5. 2 Usersリソース
  
    # ログイン機能
  get    '/login', to: 'sessions#new' # ログインページ
  post   '/login', to: 'sessions#create' # セッション作成（ログイン）
  delete '/logout', to: 'sessions#destroy' # セッション削除（ログアウト）  
# 9.3.1 モーダルウインドウを表示しよう
  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month' # 。11. 1 勤怠編集ページを作ろう
      patch 'attendances/update_one_month' # 11. 1. 5 まとめて更新ボタンを作ろう（形だけ）
    end
    resources :attendances, only: :update # 10.5出勤登録ボタンを作ろう
  end
  
end
