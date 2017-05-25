module LeagueRankings
  # Calculate league standings from an array of game results
  # @param [GameResults]
  # @param League
  class CalculateGameResults
    POINTS_WIN = 3
    POINTS_TIE = 1

    def initialize(game_results, league)
      @game_results = game_results
      @league = league
    end

    def calculate_result(game_result)
      home_team = @league.team_by_name(game_result.home_name)
      away_team = @league.team_by_name(game_result.away_name)
      away_team.award(POINTS_WIN) if game_result.away_won?
      home_team.award(POINTS_WIN) if game_result.home_won?
      away_team.award(POINTS_TIE) & home_team.award(1) if game_result.tie?
    end

    def calculate
      @game_results.each do |game_result|
        calculate_result(game_result)
      end
    end
  end
end
