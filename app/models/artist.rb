class Artist < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :songs, dependent: :destroy

  def to_s
    name
  end
end
