class AddProfileToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :profile, :json
  end
end
