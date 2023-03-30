class CreateRoomCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :room_categories do |t|

      t.references :category, null: false, index:true, foreign_key: true
      t.references :room, null: false, index:true, foreign_key: true
      t.timestamps
    end
  end
end
