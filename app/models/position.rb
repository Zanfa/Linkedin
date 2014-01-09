class Position < ActiveRecord::Base

  validates_uniqueness_of :title, scope: [:organization, :connection_id]

  belongs_to :connection

end
