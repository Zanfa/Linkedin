class Aggregator < ActiveRecord::Base
  before_save :generate_invite_key

  belongs_to :owner, class_name: 'User'

  private
  def generate_invite_key
    unless self.invite_key
      self.invite_key = SecureRandom.uuid
      self.invite_url =
          Googl.shorten(Rails.application.routes.url_helpers.invite_url(self.invite_key)).short_url
    end
  end
end
