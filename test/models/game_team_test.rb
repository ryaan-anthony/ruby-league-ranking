require './test/test_case'
class GameTeamTest < TestCase
  def test_structure
    team = LeagueRankings::GameTeam.new(name: 'Test', score: 100)
    assert_equal(team.name, 'Test')
    assert_equal(team.score, 100)
  end
end
