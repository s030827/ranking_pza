module Elasticsearch
  class PartnerQueryBuilder
    attr_reader :params, :query, :sort

    def initialize(params = {})
      @params = params
      @query = { 'bool': { 'must': [] } }
      @sort = []
    end

    def call
      query[:bool][:must].push('match_all': {})
      query[:bool].merge!(
        filter: {
          geo_distance: {
            distance: '10km',
            location: {
              lat: 50.0802,
              lon: 19.8981
            }
          }
        }
      )
      # filter_by_full_name
      # sort_by_address
      { 'query' => query }
    end

    private

    def users_in_given_distance
      # {
      #   "query": {
      #       "bool" : {
      #           "must" : {
      #               "match_all" : {}
      #           },
      #           "filter" : {
      #               "geo_distance" : {
      #                   "distance" : "10km",
      #                   "location" : {
      #                       "lat" : 50.0802,
      #                       "lon" : 19.8981
      #                   }
      #               }
      #           }
      #       }
      #   }
      # }
    end

    def filter_by_full_name
      # TODO: implement this method
    end

    def sort_by_address
      # TODO: implement this method
    end
  end
end

def partner_search(query)
  # self.search({
  #   query: {
  #     bool: {
  #       must: [
  #       {
  #         multi_match: {
  #           query: query,
  #           fields: [:author, :title, :body, :tags]
  #         }
  #       },
  #       {
  #         match: {
  #           published: true
  #         }
  #       }]
  #     }
  #   }
  # })
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
