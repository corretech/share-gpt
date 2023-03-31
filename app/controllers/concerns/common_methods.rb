module CommonMethods
    def chats_to_hash(chats)
        messages = []
        chats.each do |chat|
            messages.push({role: "user", content: chat.question}) if chat.question.present?
            messages.push({role: "assistant", content: chat.answer}) if chat.answer.present?
        end
        messages
    end
    
    def update_total_views(chats)
        chats.each do |chat|
            chat.update(total_views: chat.total_views + 1)
        end
    end
end