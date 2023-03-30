class Chat < ApplicationRecord
    belongs_to :user
    belongs_to :room
    belongs_to :prequel, class_name: 'Chat', foreign_key: :prequel_chat_id, optional: true
    has_many :sequels, class_name: "Chat", dependent: :destroy
    has_many :likes, class_name: "ChatLike", dependent: :destroy
    has_many :upper_contexts, class_name: "Context", dependent: :destroy
    has_many :bottom_contexts, class_name: "Context", dependent: :destroy
    has_many :uppers, through: :upper_contexts, source: :upper_chat
    has_many :bottoms, through: :bottom_contexts, source: :bottom_chat

    validates :question, length: {maximum: :max_characters}, presence: true
    def max_characters
        2500
    end
end
