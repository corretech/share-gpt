class Host < ApplicationRecord
    has_many :chats
    has_many :comments
    has_many :rooms
    validates :name, length: {maximum: :max_name_length}, presence: true
    def max_name_length
        15
    end
end
