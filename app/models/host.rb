class Host < ApplicationRecord
    has_many :chats
    has_many :comments, dependent: :destroy
    has_many :comment_likes, dependent: :destroy
    has_many :rooms
    validates :name, length: {maximum: :max_name_length}
    before_validation :set_uuid
    after_initialize :set_default, if: :new_record?

    def set_uuid
      while self.host_id.blank? || Host.find_by(id: self.host_id).present? do
        self.host_id = "host-#{SecureRandom.uuid}"
      end
    end

    def set_default
        while self.host_id.blank? || Host.find_by(id: self.host_id).present? do
          self.host_id = "host-#{SecureRandom.uuid}"
        end
    end

    def max_name_length
        15
    end
end
