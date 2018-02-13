class CreateInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :insurances do |t|
      t.integer :grade
      t.string :status
      t.integer :exporter_id

      t.timestamps
    end
    add_index :insurances, :grade
    add_index :insurances, :exporter_id
  end
end
