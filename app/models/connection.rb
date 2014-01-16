class Connection < ActiveRecord::Base
  searchkick

  belongs_to :user

  validates_uniqueness_of :linkedin_id
  has_and_belongs_to_many :users

  def should_crawl?
    last_crawled == nil || Time.now - 1.day > last_crawled
  end

end
