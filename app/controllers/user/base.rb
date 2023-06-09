class User::Base < ApplicationController
    before_action :check_session
    before_action :set_default_value

    def set_default_value
        gon.chat_pages = 5
        gon.comment_pages = 5
        gon.is_loaded = true
    end

    def check_session
        if session[:host_id].present?
            puts "旧セッション"
            puts session[:host_id]
            @current_host = Host.find_by(host_id:session[:host_id])
            if !@current_host.present?
                create_user
            end
        else
            create_user
        end
    end
    
    def create_user
        puts "新セッション"
        ip_address = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
        @current_host = Host.new(
            source: ip_address.to_s
        )
        puts "保存"
        puts @current_host.name
        session[:host_id] = @current_host.host_id
    end

    def save_host
        @current_host.name = @chat.user_name if defined? @chat
        @current_host.name = @comment.user_name if defined? @comment
        @current_host.save!
    end

    def search_chat
        if @category.present?
            @chats = @category.chats.order(created_at: :DESC)
        elsif params[:category_id] == "popular"
            @chats = @chats.where("? < created_at", DateTime.now - 30)
            @chats = @chats.order(total_likes: :DESC)
        end
        puts "AIメソッド"
        if @ai_method.present?
            puts @ai_method.name
            @chats = @ai_method.chats
        end
    end
end