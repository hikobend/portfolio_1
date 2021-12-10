class Todo < ApplicationRecord
    belongs_to :user

    with_options presence: true do
        validates :title3
        validates :body
    end
end
