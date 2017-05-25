module LeagueRankings
  # Award points to a team
  module Awardable
    def award(points)
      @overall_score += points
    end
  end
end
