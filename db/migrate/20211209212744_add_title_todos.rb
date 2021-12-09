class AddTitleTodos < ActiveRecord::Migration[6.1]
  def change
    add_column :todos, :title3, :string
  end
end
