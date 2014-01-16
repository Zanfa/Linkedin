class AddLastCrawledToUsersConnections < ActiveRecord::Migration
  def change
    add_column :users, :last_crawled, :datetime
    add_column :connections, :last_crawled, :datetime
  end
end
