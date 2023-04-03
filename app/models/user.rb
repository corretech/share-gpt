class User < ApplicationRecord
  has_many :chats
  has_many :comments
  has_many :rooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  before_create :set_uuid

  private
  def set_uuid
    while self.user_id.blank? || User.find_by(user_id: self.user_id).present? do
      self.user_id = "user-#{SecureRandom.uuid}"
    end
  end
end
