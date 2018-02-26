class User < ApplicationRecord
  validates_presence_of :name, :surname
  has_many :ascents
  has_many :lines, through: :ascents

  def full_name
    "#{name} #{surname}"
  end

  def self.men
    where(sex: 'M')
  end

  def self.women
    where(sex: 'F')
  end

end
