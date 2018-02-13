class CreateArchivedExporters < ActiveRecord::Migration[5.0]
  def change
    create_table :archived_exporters do |t|
      t.string :model_action
      t.json :attributes
      t.references :exporter, foreign_key: true

      t.timestamps
    end
  end
end