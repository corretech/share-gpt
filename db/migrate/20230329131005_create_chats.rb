class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user, index:true, foreign_key: true
      t.references :host, index:true, foreign_key: true
      t.references :room, null: false, index:true, foreign_key: true
      t.references :prequel_chat, index:true, foreign_key: { to_table: :chats }
      t.text :question
      t.text :answer
      t.integer :number
      t.integer :total_views, default: 0, index: true
      t.integer :total_likes, default: 0, index: true
      t.integer :total_comments, default: 0, index: true
      t.integer :total_chats, default: 0, index: true
      t.timestamps
    end
  end
end
