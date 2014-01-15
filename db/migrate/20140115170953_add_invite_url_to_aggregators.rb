class AddInviteUrlToAggregators < ActiveRecord::Migration
  def change
    add_column :aggregators, :invite_url, :string
  end
end
