class CreateArchivedInsurances < ActiveRecord::Migration[5.0]
  def change
    create_table :archived_insurances do |t|
      t.string :model_action
      t.json :snapshot
      t.references :insurance

      t.timestamps
    end
  end
end
