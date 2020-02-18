class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 6. 3モジュールの読み込みを設定
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
end
