class Line < ApplicationRecord
  validates_presence_of :name, :grade, :crag, :kind
  #validates_uniqueness_of :name, scope: :crag
  #validates :kind, inclusion: { in: %w('b', 's') }
  has_many :ascents
  has_many :users, through: :ascents
end
