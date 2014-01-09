class AddUsersToAggregators < ActiveRecord::Migration
  def change
    add_column :aggregators, :users, :integer, array: true
    remove_column :users, :aggregator_id
  end
end
