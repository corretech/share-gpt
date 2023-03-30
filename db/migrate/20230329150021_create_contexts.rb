class CreateContexts < ActiveRecord::Migration[6.1]
  def change
    create_table :contexts do |t|

      t.references :upper_chat, null: false, index:true, foreign_key: { to_table: :chats }
      t.references :bottom_chat, null: false, index:true, foreign_key: { to_table: :chats }
      t.timestamps
    end
  end
end
