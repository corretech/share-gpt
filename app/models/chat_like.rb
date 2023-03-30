class ChatLike < ApplicationRecord
    belongs_to :user
    belongs_to :prequel, class_name: 'Chat', foreign_key: :chat_id
end
