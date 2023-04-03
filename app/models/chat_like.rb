class ChatLike < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :chat, class_name: 'Chat', foreign_key: :chat_id
    validates :chat_id, uniqueness: { scope: [:user_id, :host_id] }

    after_commit :update_total_likes

    def update_total_likes
        self.update_total_likes
    end
end
