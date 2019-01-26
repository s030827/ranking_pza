class City < ApplicationRecord
  include Elasticsearch::Model

  has_and_belongs_to_many :zips
  belongs_to :country

  settings index: {
    analysis: {
      analyzer: {
        analyzer_startswith: {
          tokenizer: 'keyword',
          filter: 'lowercase'
        }
      }
    }
  } do
    mapping do
      indexes :name, analyzer: 'analyzer_startswith'
      indexes :country
      indexes :zips_count, type: 'integer'
    end
  end

  def as_indexed_json(options = {})
    {
      name: name,
      country: country.iso,
      zips_count: zips.count
    }
  end
end
