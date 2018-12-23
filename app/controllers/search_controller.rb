class SearchController < ApplicationController

  def show
    @users = User.search(search_params)
    @show_distance = @users.first[:fields] unless @users.empty?
  end

  private

  def search_params
    return unless params[:search]
    Elasticsearch::PartnerQueryBuilder.new(params).call
  end
end
