class CreateChatCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_categories do |t|

      t.references :category, null: false, index:true, foreign_key: true
      t.references :chat, null: false, index:true, foreign_key: true
      t.timestamps
    end
  end
end
