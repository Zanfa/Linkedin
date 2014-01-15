class CreateAggregatorsUsers < ActiveRecord::Migration
  def change
    create_table :aggregators_users, id: false do |t|
      t.references :aggregator, index: true
      t.references :user, index: true
    end
  end
end
