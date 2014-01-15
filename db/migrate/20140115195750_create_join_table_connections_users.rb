class CreateJoinTableConnectionsUsers < ActiveRecord::Migration
  def change
    create_table :connections_users, id: false do |t|
      t.references :connection
      t.references :user
    end
  end
end
