class RankingController < ApplicationController
  def index
    @women_s = PZA::Ranking.new(User.women, '2017', 's').call.first(5)
    @men_s = PZA::Ranking.new(User.men, '2017', 's').call.first(5)
    @women_b = PZA::Ranking.new(User.women, '2017', 'b').call.first(5)
    @men_b = PZA::Ranking.new(User.men, '2017', 'b').call.first(5)
  end
end
