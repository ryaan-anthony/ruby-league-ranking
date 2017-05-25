require './test/test_case'
class LeagueTeamTest < TestCase
  def test_structure
    team = LeagueRankings::LeagueTeam.new(name: 'Test', overall_score: 100)
    assert_equal(team.name, 'Test')
    assert_equal(team.overall_score, 100)
  end
end
