module Api
  class PlacesAutocompleteController < ActionController::Base
    FORBIDDEN_CHARACTERS = /[^a-zA-Z0-9]+/

    respond_to :json

    def show
      sanitize_search_term
      respond_with cities.to_json
    end

    private

    def sanitize_search_term
      params[:term].gsub!(FORBIDDEN_CHARACTERS, "") if params[:term].match(FORBIDDEN_CHARACTERS)
    end

    def cities
      City.search({
        "size": 5,
        "query": { "regexp": { "name": "#{params[:term]}.*" } },
        "sort": { "zips_count": { "order": "desc" } }
      }).map(&:name)
    end
  end
end
