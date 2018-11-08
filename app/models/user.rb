require 'elasticsearch/model'

class User < ApplicationRecord
  include Elasticsearch::Model
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :surname
  validates :email, uniqueness: { allow_blank: true }
  has_many :ascents
  has_many :lines, through: :ascents

  scope :men, -> { where(sex: 'M') }
  scope :women, -> { where(sex: 'F') }

  mapping do
    indexes :location, type: 'geo_point'
    indexes :ascents, type: 'nested' do
      indexes :kind
      indexes :style
      indexes :line do
        indexes :grade
      end
    end
  end

  def as_indexed_json(options = {})
    as_json(
        only: [
          :id, :name, :surname, :sex, :email, :city, :zip,
        ],
        include: {
          ascents: {
            only: [:kind, :style],
            include: { line: { only: :grade } }
          }
        }
    ).merge(location: { lat: self.lat, lon: self.lng })
  end
end
