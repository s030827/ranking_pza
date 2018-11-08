class SearchController < ApplicationController

  def create
    find_users
    redirect_to search_path
  end

  def show; end

  private

  def find_users
    params = Elasticsearch::PartnerQueryBuilder.new(params).call
    @users = User.search(params)
  end
end
