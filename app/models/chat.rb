class Chat < ApplicationRecord
    require 'open-uri'
    mount_uploader :image, ImageUploader
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :room
    belongs_to :ai_method
    belongs_to :prequel, class_name: 'Chat', foreign_key: :prequel_chat_id, optional: true
    has_many :sequels, class_name: "Chat", dependent: :destroy, foreign_key: :prequel_chat_id
    has_many :likes, class_name: "ChatLike", dependent: :destroy
    has_many :upper_contexts, class_name: "Context", foreign_key: :bottom_chat_id, dependent: :destroy
    has_many :bottom_contexts, class_name: "Context", foreign_key: :upper_chat_id, dependent: :destroy
    has_many :uppers, through: :upper_contexts, source: :upper_chat
    has_many :bottoms, through: :bottom_contexts, source: :bottom_chat

    has_many :chat_categories, class_name: "ChatCategory", foreign_key: :chat_id, dependent: :destroy
    has_many :categories, through: :chat_categories

    has_many :comments
    validate :validate_prequel
    validate :check_host_name

    before_validation :create_room
    before_validation :set_default_value
    before_create :save_image
    after_save :create_contexts
    after_save :update_parent_total_chats
    after_create :categorize_chat

    attr_accessor :user_name
    attr_accessor :generate_image
    attr_accessor :generate_chat

    validates :question, length: {maximum: :max_characters}, presence: true
    def max_characters
        2500
    end

    after_initialize do |chat|
        set_values_by_rules
    end

    def save_image
        if self.generate_image
            self.remote_image_url = self.original_image
        end
    end

    def set_values_by_rules
        if self.ai_method_id
            self.generate_image = self.ai_method.name == "generate_image"
            self.generate_chat = self.ai_method.name == "generate_chat"
        end
        #画像を生成するなら前のチャットはなし
        if self.ai_method.present? && self.ai_method.name == "generate_image"
            self.prequel = nil
        end
        #前のチャットが画像生成なら前のチャットにできない
        if self.prequel.present? && self.prequel.ai_method.present?
            self.prequel = nil if self.prequel.ai_method.name == "generate_image"
        end
    end

    def set_default_value
        set_values_by_rules
        #チャットの番号を定義
        if self.prequel.present?
            self.number = self.prequel.uppers.count + 2
        else
            self.number = 1
        end
    end

    def validate_prequel
        errors.add(:prequel) if self.prequel == self
        #errors.add(:prequel)
    end

    def create_room
        if !self.room_id.present?
            if self.prequel.present?
                self.room = self.prequel.room
            else
                if self.host.present?
                    self.room = Room.new(host: self.host)
                elsif self.user.present?
                    self.room = Room.new(user: self.user)
                else
                end
            end
        end
    end

    def categorize_chat
        categorize(self)
    end

    def check_host_name
        if self.host && !self.host.name.present?
            errors.add(:user_name)
        end
    end

    def create_contexts
        if self.prequel
            Context.create(
                upper_chat: self.prequel,
                bottom_chat: self,
            )
            self.prequel.uppers.each do |chat|
                Context.create(
                    upper_chat: chat,
                    bottom_chat: self,
                )
            end
        end
    end

    def update_total_chats
        self.update(total_chats: Chat.where(prequel: self).count)
    end

    def update_total_comments
        self.update(total_comments: Comment.where(chat: self).count)
    end
    
    def update_total_likes
        self.update(total_likes: ChatLike.where(chat: self).count)
    end

    def update_parent_total_chats
        self.prequel.update_total_chats if self.prequel_chat_id
        self.room.update_total_chats
    end
end
