class AddDoneTodos < ActiveRecord::Migration[6.1]
  # 新しく追加 :completeを指定する
  def change
    add_column :todos, :complete, :boolean, default: false, null: false
  end
end
