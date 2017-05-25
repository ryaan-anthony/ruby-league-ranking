module LeagueRankings
  # Determine if a game is won or lost
  module Winnable
    def home_won?
      @home_score > @away_score
    end

    def away_won?
      @home_score < @away_score
    end

    def tie?
      @home_score == @away_score
    end
  end
end
