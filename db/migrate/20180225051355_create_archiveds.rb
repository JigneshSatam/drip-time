class CreateArchiveds < ActiveRecord::Migration[5.0]
  def change
    create_table :archiveds do |t|
      t.string :model_action
      t.json :snapshot
      t.string :type
      t.integer :archiver_id

      t.timestamps
    end
  end
end
