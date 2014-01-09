class CreateAggregators < ActiveRecord::Migration
  def change
    create_table :aggregators do |t|
      t.string :name
      t.string :invite_key
      t.belongs_to :owner, index: true, class_name: 'User'

      t.timestamps
    end
  end
end
