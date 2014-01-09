class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.string :title
      t.string :organization
      t.references :connection, index: true

      t.timestamps
    end
  end
end
