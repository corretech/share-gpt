class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.references :user, index:true, foreign_key: true
      t.references :host, index:true, foreign_key: true
      t.references :chat, null: false, index:true, foreign_key: true
      t.references :comment, index:true, foreign_key: true
      t.text :body

      t.integer :total_views, default: 0, index: true
      t.integer :total_likes, default: 0, index: true
      t.integer :total_chats, default: 0, index: true
      t.integer :total_comments, default: 0, index: true
      t.timestamps
    end
  end
end
