class User < ActiveRecord::Base

  has_and_belongs_to_many :pools
  has_and_belongs_to_many :connections

  def self.with(auth_hash)
    User.where(linkedin_id: auth_hash[:uid]).first_or_create do |user|
      user.linkedin_token = auth_hash[:credentials][:token]
      user.linkedin_secret = auth_hash[:credentials][:secret]
    end
  end

  def should_crawl?
    last_crawled == nil || Time.now - 1.day > last_crawled
  end

end
