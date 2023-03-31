class User::ChatLikesController < User::Base
    def create
        if user_signed_in?
            Chat.find(params[:chat_id]).likes.create(user: current_user)
        else
            Chat.find(params[:chat_id]).likes.create(host: @current_host)
        end
    end
end
