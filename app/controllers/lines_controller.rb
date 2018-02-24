class LinesController < ApplicationController
  def index
    @lines = Line.all.order(:name).page(params[:page])
  end
end
