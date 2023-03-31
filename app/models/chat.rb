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
    validate :validate_prequel

    before_validation :create_room
    before_validation :set_default_value
    after_save :create_contexts

    after_find do |user|
        puts "オブジェクトが見つかりました"
        self.update(total_views: self.total_views + 1)
    end

    validates :question, length: {maximum: :max_characters}, presence: true
    def max_characters
        2500
    end

    def set_default_value
        puts "番号"
        if self.prequel.present?
            self.number = self.prequel.uppers.count + 1
        else
            self.number = 1
        end
        puts self.number
    end

    def validate_prequel
        errors.add(:prequel) if self.prequel == self
        #errors.add(:prequel)
    end

    def create_room
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
end
