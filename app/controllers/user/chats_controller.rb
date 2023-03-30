class User::ChatsController < User::Base
    def new
        @chats = Chat.where(room_id:params[:room_id])
        @chat = Chat.new(prequel_chat_id:1)
    end

    def create
        @chat = Chat.new(chat_params)
        if user_signed_in?
            @chat.user = current_user
        end
        
        #response = client.chat(
        #    parameters: {
        #        model: "gpt-3.5-turbo",
        #        messages: shiritori,
        #    })
        #puts response.dig("choices", 0, "message", "content")
    end

    def show
        @chat = Chat.find(params[:id])
        @new_chat = Chat.new(room_id:@chat.room_id, prequel_chat_id: params[:id])
    end

    def chat_params
        params.require(:chat).permit(
            :parent_chat_id,
            :answer,
        )
    end
end
