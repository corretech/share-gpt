class User::RoomsController < User::Base
    def index
        @chat = Chat.new()
        @chats = Chat.all
        search_chat
        @chats = @chats.where(prequel: nil).order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
    end

    def page
        puts "ルーム" + params[:page]
        @chats = Chat.all
        search_chat
        @chats = @chats.where(prequel: nil).all.order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
        puts @chats.all.count
        #update_total_views(@chats)
        render partial: "user/chats/page", locals: { contents: @chats }
    end
end
