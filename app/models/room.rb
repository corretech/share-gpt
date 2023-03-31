class Room < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    has_many :chats

    after_save :notify
    def notify
        puts "部屋が作成"
        puts "部屋が作成"
        puts "部屋が作成"
        puts "部屋が作成"
    end
end
