class AddAggregatorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :aggregator_id, :integer, index: true
  end
end
