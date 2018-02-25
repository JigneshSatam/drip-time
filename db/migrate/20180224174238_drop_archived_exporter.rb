class DropArchivedExporter < ActiveRecord::Migration[5.0]
  def up
    drop_table :archived_exporters
  end

  def down
    create_table :archived_exporters do |t|
      t.string :model_action
      t.json :snapshot
      t.references :exporter

      t.timestamps
    end
  end
end
