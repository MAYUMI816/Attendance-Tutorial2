class AddAdminToUsers < ActiveRecord::Migration[5.1]
  #8. 5. 1 管理権限属性を追加
  def change
    add_column :users, :admin, :boolean, default: false
  end
end