class Room < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    has_many :chats
end
