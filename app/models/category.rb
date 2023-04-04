class Category < ApplicationRecord
    belongs_to :parent_category, class_name: 'Category', foreign_key: :parent_category_id, optional: true
    has_many :child_categories, class_name: "Category", dependent: :destroy, foreign_key: :parent_category_id
    has_many :chat_categories
    has_many :chats, through: :chat_categories, source: :chat
end
