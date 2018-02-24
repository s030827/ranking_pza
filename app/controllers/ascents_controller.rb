class AscentsController < ApplicationController
  def index
    @ascents = Ascent.all.includes(:user).includes(:line).page(params[:page])
  end
end
