class CreateAnalytics < ActiveRecord::Migration[5.0]
  def change
    create_table :analytics do |t|
      t.integer :visits
      t.integer :views
      t.string :campaign

      t.timestamps
    end
  end
end
