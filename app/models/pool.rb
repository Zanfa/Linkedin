class Pool < ActiveRecord::Base
  before_save :generate_invite_key

  belongs_to :owner, class_name: 'User'

  has_and_belongs_to_many :users
  has_many :connections, through: :users

  validates_presence_of :name

  private
  def generate_invite_key
    unless self.invite_key
      self.invite_key = SecureRandom.uuid
      self.invite_url =
          Googl.shorten(Rails.application.routes.url_helpers.invite_url(self.invite_key)).short_url
    end
  end
end
