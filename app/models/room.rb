class Room < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    has_many :chats

    def update_total_chats
        self.update(total_chats: Chat.where(room: self).count)
    end

    def update_total_comments
        self.update(total_comments: Comment.left_joins(:chat).where(chat: {room: self}).count)
    end
end
