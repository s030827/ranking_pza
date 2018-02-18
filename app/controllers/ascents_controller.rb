class AscentsController < ApplicationController
  def index
    @ascents = Ascent.all.includes(:user).includes(:line)
  end
end
