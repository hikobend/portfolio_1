class AddReleaseTodos < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :release, :boolean, default: false, null: false
  end
end
