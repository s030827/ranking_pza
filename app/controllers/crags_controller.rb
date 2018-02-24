class CragsController < ApplicationController
  def show
    @lines = Line.where(crag: params[:crag]).order(grade: :desc)
  end
end
