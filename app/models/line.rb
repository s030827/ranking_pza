class Line < ApplicationRecord
  validates_presence_of :name, :grade, :crag, :type
  validates :name, uniqueness: { case_sensitive: false }
  has_many :ascents
  has_many :users, through: :ascents
end
