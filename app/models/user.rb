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
    indexes :ascents, type: 'nested' do
      indexes :kind
      indexes :style
      indexes :line do
        indexes :grade
      end
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
      options.merge(
        only: [:id, :name, :surname, :sex, :email, :city, :zip],
        include: {
          ascents: {
            only: [:kind, :style],
            include: { line: { only: :grade } }
          }
        }
      )
    )
  end

  def partner_search(query)
    self.search({
      query: {
        bool: {
          must: [
          {
            multi_match: {
              query: query,
              fields: [:author, :title, :body, :tags]
            }
          },
          {
            match: {
              published: true
            }
          }]
        }
      }
    })
  end

  def full_name
    "#{name} #{surname}"
  end

  def users_who_made_8b_os
    # {
    #   "query": {
    #       "nested" : {
    #           "path" : "ascents",
    #           "query" : {
    #               "bool" : {
    #                   "must" : [
    #                   { "match" : {"ascents.kind": "s"} },
    #                   { "match" : {"ascents.style": "os"} },
    #                   { "match" : {"ascents.line.grade": "8b"} }
    #                   ]
    #               }
    #           }
    #       }
    #   }
    # }
  end
end
