class LinesController < ApplicationController
  def index
    @lines = Line.all.order(:name).page(params[:page])
  end

  def show
    @line = Line.find(params[:id])
  end
end
