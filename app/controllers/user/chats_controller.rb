class User::ChatsController < User::Base
    after_action :increment_total_views, only:[:show]
    #require "openai"
    def index
        @chats = Chat.all
        search_chat
        @chats = @chats.page(params[:page]).per(gon.chat_pages)
        #update_total_views(@chats)
    end

    def page
        puts "ページ" + params[:page]
        @chats = Chat.all
        search_chat
        @chats = @chats.all.order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
        puts @chats.all.count
        #update_total_views(@chats)
        render partial: "user/chats/page", locals: { contents: @chats }
    end

    def sequels
        puts "ページ" + params[:page]
        @chats = Chat.where(prequel_chat_id: params[:id]).order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
        puts @chats.all.count
        update_total_views(@chats)
        render partial: "user/chats/page", locals: { contents: @chats }
    end

    def comments
        puts "ページ" + params[:page]
        @comments = Comment.where(chat_id: params[:id]).order(created_at: :DESC).page(params[:page]).per(gon.comment_pages)
        puts @comments.all.count
        update_total_views(@comments)
        render partial: "user/comments/page", locals: { contents: @comments }
    end

    def new
        @chat = Chat.new()
    end

    def create
        @chat = Chat.new(chat_params)
        if user_signed_in?
            @chat.user = current_user
        else
            @chat.host = @current_host
            session[:user_name] = params[:chat][:user_name]
        end
        
        if @chat.generate_chat
            generate_chat
        end

        puts "イメージ生成"
        puts @chat.generate_image
        if @chat.generate_image
            puts "イメージを生成中"
            generate_image
        end

        if save_host && @chat.save
            flash.alert = "送信しました"
            redirect_to user_chat_path(@chat.id)
        elsif true #Rails.env.production?
            @model = @chat
            @chat = @chat.prequel
            if @chat.present?
                @new_chat = Chat.new(prequel_chat_id: params[:id])
                @sequels =  @chat.sequels.page(params[:page]).per(1)
                @uppers = @chat.uppers.order(created_at: :asc)
                render "user/chats/show"
            else
                @chat = Chat.new()
                render "user/chats/new"
            end
        end
    end

    def generate_image
        url = "http://127.0.0.1:5000/image/#{URI.encode_www_form_component(@chat.question)}"
        html = URI.open(url) do |f|
            charset = f.charset
            url = f.read
        end
        @chat.original_image = url
        puts "イメージ"
        puts url
    end

    def generate_chat
        if @chat.prequel
            all_chats = chats_to_hash(@chat.prequel.uppers.order(created_at: :asc))
            all_chats.push({role: "user", content: @chat.prequel.question})
            all_chats.push({role: "assistant", content: @chat.prequel.answer})
        else
            all_chats = []
            @chat.room = Room.new()
        end
        all_chats.push({role: "user", content: @chat.question})
        puts "すべてのチャット"
        puts all_chats

        client = OpenAI::Client.new(access_token: ENV["GPT_TOKEN"])

        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: all_chats,
            })
        @chat.answer = response.dig("choices", 0, "message", "content")
        puts "回答"
        puts response
    end

    def show
        @chat = Chat.find(params[:id])
        gon.id = params[:id]
        @uppers = @chat.uppers.order(created_at: :asc)
        update_total_views(@uppers)

        @new_chat = Chat.new(room_id:@chat.room_id, prequel_chat_id: params[:id])
        puts "ページ"
        puts gon.chat_pages
        @sequels = @chat.sequels.page(params[:page]).order(created_at: :DESC).per(gon.chat_pages)
        update_total_views(@sequels)

        @new_comment = Comment.new(chat_id: params[:id])
        @comments = @chat.comments.page(params[:page]).order(created_at: :DESC).per(gon.comment_pages)
    end

    def increment_total_views
        puts "バリデーション"
        puts @chat.valid?
        puts @chat.errors.full_messages
        @chat.update(total_views: @chat.total_views + 1)
    end

    def chat_params
        params.require(:chat).permit(
            :user_name,
            :prequel_chat_id,
            :question,
            #:generate_image,
            #:generate_chat,
            :ai_method_id,
        )
    end
end
