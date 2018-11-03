module PZA
  class Ranking
    def initialize(users, year, kind)
      @users = users
      @year = year
      @kind = kind
    end

    def call
      @users.map do |user|
        format_user(user)
      end.sort_by { |h| h[:points] }.reverse!
    end

    private

    attr_reader :users, :year, :kind

    def format_user(user)
      {
        id: user.id,
        full_name: "#{user.name} #{user.surname}",
        points: calculate_points(user)
      }
    end

    def calculate_points(user)
      Ascent.includes(:user)
        .where(user: user)
        .by_year(year)
        .where(kind: kind)
        .order(points: :desc)
        .limit(10)
        .sum(&:points)
    end
  end
end
