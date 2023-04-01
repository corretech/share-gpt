class User::CommentsController < User::Base
    def page
        puts "ページ" + params[:page]
        @comments = Comment.all.order(created_at: :DESC).page(params[:page]).per(gon.comment_pages)
        puts @comments.all.count
        update_total_views(@comments)
        render partial: "user/comments/page", locals: { contents: @comments }
    end

    def create
        @comment = Comment.new(comments_params)
        @chat = @comment.chat
        puts "チャット"
        puts @chat.present?
        if user_signed_in?
            @comment.user = current_user
        else
            @comment.host = @current_host
            @comment.host.name = @comment.user_name
            @comment.host.save!
        end

        if @comment.save
            flash.alert = "送信しました"
            redirect_to user_chat_path(@chat.id, bottom: "comment")
        else
            @model = @comment
            @uppers = @chat.uppers.order(created_at: :asc)
            @new_comment = Comment.new(chat_id: params[:id])
            @comments = @chat.comments.page(params[:page]).per(1)
            params[:bottom] = "comment"
            puts params[:bottom]
            render "user/chats/show", {bottom: "comment"}
        end
    end

    private def comments_params
        params.require(:comment).permit(
            :user_name,
            :chat_id,
            :body,
        )
    end
end
