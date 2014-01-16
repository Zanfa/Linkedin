class RenameAggregatorsToPools < ActiveRecord::Migration
  def change
    rename_table :aggregators, :pools

    rename_column :aggregators_users, :aggregator_id, :pool_id
    rename_table :aggregators_users, :pools_users
  end
end
