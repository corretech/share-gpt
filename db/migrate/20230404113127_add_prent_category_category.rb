class AddPrentCategoryCategory < ActiveRecord::Migration[6.1]
  def change
    change_table(:categories) do |t|
      t.references :parent_category, add_index:true , foreign_key: { to_table: :categories }
      t.integer :total_access, default: 0, add_index:true
    end
  end
end
