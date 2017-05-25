require './test/test_case'
class ParseGameResultsTest < TestCase
  def test_parser_must_fail
    assert_raises ParserError do
      input = StringIO.new('bad syntax')
      LeagueRankings::ParseGameResults.new(input).call
    end
  end

  def test_parser_must_succeed
    input = StringIO.new('Lions 3, Snakes 3
Tarantulas 1, FC Awesome 0
Lions 1, FC Awesome 1
Tarantulas 3, Snakes 1
Lions 4, Grouches 0')
    game_results = LeagueRankings::ParseGameResults.new(input).call
    assert_equal(game_results.size, 5)
    game_results.each do |game_result|
      assert_equal(game_result.away_score > 0, true)
      assert_equal(game_result.is_a?(LeagueRankings::GameResults), true)
    end
  end
end
