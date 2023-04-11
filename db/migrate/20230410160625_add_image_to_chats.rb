class AddImageToChats < ActiveRecord::Migration[6.1]
  change_table(:chats) do |t|
    t.references :ai_method, add_index:true , foreign_key: { to_table: :ai_methods }
    t.string :image
    t.text :original_image
  end
end
