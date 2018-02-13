class CreateExporters < ActiveRecord::Migration[5.0]
  def change
    create_table :exporters do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :address

      t.timestamps
    end
    add_index :exporters, :name
    add_index :exporters, :email, unique: true
  end
end
