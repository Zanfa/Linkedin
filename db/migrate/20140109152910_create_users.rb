class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :linkedin_id
      t.string :linkedin_token

      t.timestamps
    end
  end
end
