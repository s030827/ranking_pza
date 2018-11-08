module Elasticsearch
  class PartnerQueryBuilder
    attr_reader :params, :query, :sort, :answer, :geo_coords

    def initialize(params = {})
      @params = params[:search]
      @geo_coords = set_geo_coords unless params[:search][:city_zip].empty?
      @query = { 'bool': { 'must': [] } }
      @sort = []
      @answer = {
        'query': query, 'size': 1000, 'stored_fields': ['_source']
      }
    end

    def call
      add_distance
      filter_distance
      filter_sex
      filter_ascents
      answer
    end

    private

    def add_distance
      return if geo_coords.nil?
      answer.merge!({
        script_fields: {
          distance: {
            script: {
              source: source,
              lang: 'painless',
              params: geo_coords
            }
          }
        }
      })
    end

    def set_geo_coords
      city_zip = params[:city_zip]
      res = if city_zip =~ /^\d/
        Zip.find_by(code: city_zip)
      else
        City.find_by(name: city_zip).zips.first
      end
      { lat: res&.lat.to_f, lon: res&.lng.to_f }
    end

    def source
      "doc['location'].arcDistance(params.lat, params.lon) * 0.001"
    end

    def filter_distance
      return if params[:distance].empty? || geo_coords.nil?
      query[:bool].merge!({
        filter: {
          geo_distance: {
            distance: "#{params[:distance]}km",
            location: geo_coords
          }
        }
      })
    end

    def filter_sex
      return if params[:sex].empty?
      query[:bool][:must].push(
        { match: { sex: params[:sex] } },
      )
    end

    def filter_ascents
      return if params[:kind].empty?
      query[:bool][:must].push({
        nested: {
          path: 'ascents',
          query: {
            bool: {
              must: [
                { match: { 'ascents.kind': params[:kind] } },
                { match: { 'ascents.style': params[:style] } },
                { match: { 'ascents.line.grade': params[:grade] } }
              ]
            }
          }
        }
      })
    end
  end
end
