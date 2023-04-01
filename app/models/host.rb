class Host < ApplicationRecord
    has_many :chats
    has_many :comments, dependent: :destroy
    has_many :comment_likes, dependent: :destroy
    has_many :rooms
    validates :name, length: {maximum: :max_name_length}
    def max_name_length
        15
    end
end
