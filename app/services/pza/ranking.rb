module PZA
  class Ranking
    def initialize(users, year, kind)
      @users = users
      @year = year
      @kind = kind
    end

    def call
      @users.includes(:ascents).map do |user|
        pts = points(user)
        next if pts == 0
        {
          full_name: user.full_name,
          points: points(user),
          id: user.id
        }
      end.compact.sort_by { |hsh| hsh[:points] }.reverse!
    end

    def points(user)
      PZA::CalculateYearPoints.new(user, @year, @kind).call
    end
  end
end
