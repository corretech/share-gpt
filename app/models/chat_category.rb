class ChatCategory < ApplicationRecord
    belongs_to :category, class_name: 'Category', foreign_key: :category_id
    belongs_to :chat, class_name: "Chat", foreign_key: :chat_id

    after_save :create_parent_category

    def create_parent_category
        if self.category.parent_category
            ChatCategory.create(
                chat: self.chat,
                category: self.category.parent_category
            )
        end
    end
end
