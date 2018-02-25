module PZA
  class CalculateYearPoints
    def initialize(user, year, kind)
      @user = user
      @year = year
      @kind = kind
    end

    def call
      @user
        .ascents
        .by_year(@year)
        .where(kind: @kind)
        .order(points: :desc)
        .limit(10)
        .sum(&:points)
    end
  end
end
