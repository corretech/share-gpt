class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :chat

    validates :body, length: {maximum: :max_characters}, presence: true
    def max_characters
        1000
    end
end
