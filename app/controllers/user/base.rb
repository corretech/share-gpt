class User::Base < ApplicationController
    before_action :check_session
    def check_session
        if session[:user_id].present?
            puts "旧セッション"
            puts session[:user_id]
            @current_host = Host.find_by(ip_address: session[:user_id])
            if !@current_host.present?
                create_user
            end
        else
            create_user
        end
    end
    
    def create_user
        puts "新セッション"
        ip_address = request.remote_ip
        session[:user_id] = ip_address
        @current_host = Host.new(
            ip_address:ip_address
        )
        @current_host.save
    end
end