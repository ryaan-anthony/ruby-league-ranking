require './test/test_case'
class GameResultsTest < TestCase
  def test_winning
    game_results = LeagueRankings::GameResults.new(away_score: 1, home_score: 5)
    assert_equal(game_results.home_score, 5)
    assert_equal(game_results.away_score, 1)
    assert_equal(game_results.home_won?, true)
    assert_equal(game_results.away_won?, false)
    assert_equal(game_results.tie?, false)
  end
end
