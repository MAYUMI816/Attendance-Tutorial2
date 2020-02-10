class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper # 6. 3モジュールの読み込みを設定
end
