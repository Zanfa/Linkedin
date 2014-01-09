class AddLinkedinSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_secret, :string
  end
end
