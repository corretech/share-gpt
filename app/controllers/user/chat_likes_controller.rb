class User::ChatLikesController < ApplicationController
    def create
        if user_signed_in?
            puts "ss"
            if !ChatLike.exists?(user: current_user)
                puts "いいね"
                Chat.find(params[:chat_id]).likes.create(user: current_user)
            end
        else
            puts "いいねできた"
            if !ChatLike.exists?(host: @current_host)
                puts "いいね"
                Chat.find(params[:chat_id]).likes.create(host: @current_host)
            end
        end
    end
end
