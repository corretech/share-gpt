class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.string :host_id, null: false
      t.string :source
      t.string :name

      t.timestamps
    end
  end
end
