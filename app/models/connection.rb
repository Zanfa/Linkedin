class Connection < ActiveRecord::Base
  searchkick

  belongs_to :user

  validates_uniqueness_of :linkedin_id
  has_and_belongs_to_many :users
end
