class Zip < ApplicationRecord
  has_and_belongs_to_many :cities
  acts_as_mappable
end
