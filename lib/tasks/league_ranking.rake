namespace :league_ranking do
  desc 'Calculate league ranking from game results'
  task :calculate do
    league = LeagueRankings::League.new
    game_results = LeagueRankings::ParseGameResults.new.call
    LeagueRankings::CalculateGameResults.new(game_results, league).calculate
    previous = {}
    league.teams_sorted.each_with_index do |team, index|
      tied_for_place = previous[:score] == team.overall_score
      place = tied_for_place ? previous[:place] : index + 1
      previous[:score] = team.overall_score
      previous[:place] = place
      puts "#{place}. #{team.name}, #{points_text(team.overall_score)}"
    end
  end

  def points_text(num)
    "#{num} #{num == 1 ? 'pt' : 'pts'}"
  end
end
