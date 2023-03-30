class Chat < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :room
    belongs_to :prequel, class_name: 'Chat', foreign_key: :prequel_chat_id, optional: true
    has_many :sequels, class_name: "Chat", dependent: :destroy, foreign_key: :prequel_chat_id
    has_many :likes, class_name: "ChatLike", dependent: :destroy
    has_many :upper_contexts, class_name: "Context", foreign_key: :bottom_chat_id, dependent: :destroy
    has_many :bottom_contexts, class_name: "Context", foreign_key: :upper_chat_id, dependent: :destroy
    has_many :uppers, through: :upper_contexts, source: :upper_chat
    has_many :bottoms, through: :bottom_contexts, source: :bottom_chat

    after_save :create_contexts

    validates :question, length: {maximum: :max_characters}, presence: true
    def max_characters
        2500
    end

    def create_contexts
        if self.prequel
            create_context(self.prequel)
        end
    end

    def create_context(chat)
        Context.create(
            upper_chat: chat,
            bottom_chat: self,
        )
        #前のチャットにも前のチャットがある
        if chat.prequel
            chat = self.prequel
            create_context(chat.prequel)
        end
    end
end
