Rails.application.routes.draw do
   

  #get 'static_pages/top'
  root 'static_pages#top' #get 'static_pages/top'　URL/static_pages/topから〜comで表示　
  get '/signup', to: 'users#new'# . 5. 2 ユーザールーティングの設定
  resources :users # 5. 2 Usersリソース
  
    # ログイン機能
  get    '/login', to: 'sessions#new' # ログインページ
  post   '/login', to: 'sessions#create' # セッション作成（ログイン）
  delete '/logout', to: 'sessions#destroy' # セッション削除（ログアウト）  

  resources :users
  
end
