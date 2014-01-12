class Aggregator < ActiveRecord::Base
  before_save :generate_invite_key

  belongs_to :owner, class_name: 'User'

  private
  def generate_invite_key
    self.invite_key = SecureRandom.uuid unless self.invite_key
  end
end
