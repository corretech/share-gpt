class User::CommentLikesController < User::Base
    def create
        if user_signed_in?
            Comment.find(params[:comment_id]).likes.create(user: current_user)
        elsif save_host
            Comment.find(params[:comment_id]).likes.create(host: @current_host)
        end
    end
end
