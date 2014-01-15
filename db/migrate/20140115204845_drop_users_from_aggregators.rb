class DropUsersFromAggregators < ActiveRecord::Migration
  def change
    remove_column :aggregators, :users
  end
end
