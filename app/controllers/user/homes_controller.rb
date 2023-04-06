class User::HomesController < User::Base
  def index
      @chat = Chat.new()
      @chats = Chat.where(prequel: nil).order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
      #update_total_views(@chats)
  end

  def page
      puts "ルーム" + params[:page]
      @chats = Chat.where(prequel: nil).all.order(created_at: :DESC).page(params[:page]).per(gon.chat_pages)
      puts @chats.all.count
      #update_total_views(@chats)
      render partial: "user/chats/page", locals: { contents: @chats }
  end
end
