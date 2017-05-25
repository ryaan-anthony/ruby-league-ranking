require './test/test_case'
class CalculateGameResultsTest < TestCase
  def test_calculation
    league = LeagueRankings::League.new
    LeagueRankings::CalculateGameResults.new(results_array, league).calculate
    assert_equal(league.teams.size, 4)
    assert_equal(league.teams_sorted.first.name, 'Team2')
    assert_equal(league.teams_sorted.last.name, 'Team1')
  end

  def results_array
    [
      game_results('Team1', 1, 'Team2', 5),
      game_results('Team3', 1, 'Team4', 0),
      game_results('Team1', 0, 'Team4', 4),
      game_results('Team2', 1, 'Team3', 0)
    ]
  end

  def game_results(away_name, away_score, home_name, home_score)
    LeagueRankings::GameResults.new(
      away_name: away_name,
      away_score: away_score,
      home_name: home_name,
      home_score: home_score
    )
  end
end
