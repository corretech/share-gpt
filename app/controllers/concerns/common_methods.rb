module CommonMethods
    def chats_to_hash(chats)
        messages = []
        chats.each do |chat|
            messages.push({role: "user", content: chat.question}) if chat.question.present?
            messages.push({role: "assistant", content: chat.answer}) if chat.answer.present?
        end
        messages
    end

    def chat_to_hash_tree(chats)
    end

    def append_chat(chat)
    end
end