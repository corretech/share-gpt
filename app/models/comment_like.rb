class CommentLike < ApplicationRecord
    belongs_to :user, optional: true
    belongs_to :host, optional: true
    belongs_to :comment, class_name: 'Comment', foreign_key: :comment_id
    validates :comment_id, uniqueness: { scope: [:user_id, :host_id] }
    after_commit :update_total_likes

    def update_total_likes
        self.comment.update(total_likes: CommentLike.where(comment_id: self.comment_id).count)
    end
end
