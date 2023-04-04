shiritori = [
      { role: "user", content: "しりとりしよう" },
      { role: "assistant", content: "はい、しりとりしましょう！私からは「りんご」（ringo）から始めます。" },
      { role: "user", content: "ゴリラ" },
      { role: "assistant", content: "ラッパ" },
    ]
Room.create(user_id:1, )
2.times do |n|
    Chat.create(
        room_id:1, 
        user_id:1, 
        prequel: Chat.last, 
        question: shiritori[2*n][:content],
        answer: shiritori[2*n+1][:content]
        )

end

chat = Chat.find_by(question: "しりとりしよう")
Chat.create(
    room_id: chat.room_id,
    user_id: 1,
    prequel: chat, 
    question:"ごま",
    answer:"まつたけ"
    )

chat = Chat.find_by(question: "ごま")
Chat.create(
    room_id: chat.room_id,
    user_id: 1,
    prequel: chat, 
    question:"ケーキ",
    answer:"けんきゅう"
    )

chat = Chat.find_by(question: "ケーキ")
Chat.create(
    room_id: chat.room_id,
    user_id: 1,
    prequel: chat, 
    question:"うさぎ",
    answer:"ぎんねこ"
    )