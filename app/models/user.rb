class User < ApplicationRecord
  validates_presence_of :name, :surname
  has_many :ascents
  has_many :lines, through: :ascents
end
