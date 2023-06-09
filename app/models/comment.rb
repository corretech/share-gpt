class Comment < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :chat
    has_many :likes, class_name: "CommentLike", dependent: :destroy

    attr_accessor :user_name
    validates :body, length: {maximum: :max_characters}, presence: true
    validate :check_host_name

    after_save :update_parent_total_comments

    def max_characters
        1000
    end

    def check_host_name
        if self.host && !self.host.name.present?
            errors.add(:user_name)
        end
    end

    def update_parent_total_comments
        self.chat.room.update_total_comments
        self.chat.update_total_comments
    end
end
