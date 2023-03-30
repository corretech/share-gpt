# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email:ENV["USER_EMAIL"], password:ENV["USER_PASSWORD"], password_confirmation: ENV["USER_PASSWORD"])
User.create(email:ENV["USER_EMAIL2"], password:ENV["USER_PASSWORD"], password_confirmation: ENV["USER_PASSWORD"])
Room.create(user_id:1)

shiritori = [
      { role: "user", content: "しりとりしよう" },
      { role: "assistant", content: "はい、しりとりしましょう！私からは「りんご」（ringo）から始めます。" },
      { role: "user", content: "ゴリラ" },
      { role: "assistant", content: "ラッパ" },
    ]
    
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