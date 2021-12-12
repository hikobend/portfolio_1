class Relationship < ApplicationRecord
    # Userテーブルを参照するようにする
    belongs_to :following, class_name: 'User'
    belongs_to :follower, class_name: 'User'
end
