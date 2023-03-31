class User::Base < ApplicationController
    before_action :check_session
    before_action :set_default_value

    def set_default_value
        gon.chat_pages = 4
    end

    def check_session
        if session[:user_id].present?
            puts "旧セッション"
            puts session[:user_id]
            @current_host = Host.find_by(source: session[:user_id])
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
        session[:user_id] = ip_address
        @current_host = Host.new(
            source: ip_address.to_s
        )
        puts "保存"
        puts @current_host
        puts @current_host.save
    end
end