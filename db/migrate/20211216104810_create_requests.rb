class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      # requestのFK
      t.integer :request_id
      # いつ
      t.string :when
      # どこで
      t.string :where
      # 誰が
      t.string :who
      # 何を
      t.string :what
      # なぜ
      t.text :why
      # 相手は
      t.string :whom
      # 誰と
      t.string :with
      # どのように
      t.text :how
      # どれくらいの数
      t.text :how_many
      # いくらで
      t.text :how_much
      # 重要度
      t.string :important
      # 許可する
      t.boolean :approval

      t.timestamps
    end
  end
end
