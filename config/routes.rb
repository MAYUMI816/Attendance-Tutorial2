Rails.application.routes.draw do
  #get 'static_pages/top'
  root 'static_pages#top' #get 'static_pages/top'　URL/static_pages/topから〜comで表示　
  get '/signup', to: 'users#new'# . 5. 2 ユーザールーティングの設定
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
