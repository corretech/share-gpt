class ChatLike < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :chat, class_name: 'Chat', foreign_key: :chat_id

    after_commit :update_total_likes

    def update_total_likes
        self.chat.update(total_likes: ChatLike.where(chat_id: self.chat_id).count)
    end
end
