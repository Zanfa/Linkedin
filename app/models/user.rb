class User < ActiveRecord::Base

  belongs_to :aggregator

  def self.with(auth_hash)
    User.where(linkedin_id: auth_hash[:uid]).first_or_create do |user|
      user.linkedin_token = auth_hash[:credentials][:token]
      user.linkedin_secret = auth_hash[:credentials][:secret]
    end
  end

end
