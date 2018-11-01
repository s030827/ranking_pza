require 'elasticsearch/model'

class User < ApplicationRecord
  include Elasticsearch::Model
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name, :surname
  validates :email, uniqueness: { allow_blank: true }
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
