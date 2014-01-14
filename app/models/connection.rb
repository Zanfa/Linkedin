class Connection < ActiveRecord::Base
  searchkick

  belongs_to :user

  validates_uniqueness_of :linkedin_id
end
