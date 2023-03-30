class Comment < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :chat

    validates :body, length: {maximum: :max_characters}, presence: true
    def max_characters
        1000
    end
end
