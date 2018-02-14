class CreateModifications < ActiveRecord::Migration[5.0]
  def change
    create_table :modifications do |t|
      t.string :attribute_name
      t.text :from
      t.text :to
      t.references :archivable, polymorphic: true

      t.timestamps
    end
  end
end
