class Ascent < ApplicationRecord
  validates_presence_of :style, :date
  belongs_to :user
  belongs_to :line
end
