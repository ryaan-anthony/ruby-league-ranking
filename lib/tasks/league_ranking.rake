namespace :league_ranking do
  desc 'Calculate league ranking from standings'
  task :calculate do
    # TODO: write tests
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

module LeagueRankings
  # Award points to a team
  module Awardable
    def award(points)
      @overall_score += points
    end
  end

  # A data model for teams
  class Team
    include Awardable
    attr_accessor :name, :overall_score
    def initialize(args)
      @name = args[:name]
      @overall_score = args[:overall_score] || 0
    end
  end

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

  # A data model for game results
  class GameResults
    include Winnable
    attr_reader :away_name, :home_name,
                :away_score, :home_score
    def initialize(args)
      @away_name = args[:away_name]
      @away_score = args[:away_score]
      @home_name = args[:home_name]
      @home_score = args[:home_score]
    end
  end

  # A data model for leagues
  class League
    attr_accessor :teams
    def initialize
      @teams = {}
    end

    def teams
      @teams.values
    end

    def teams_sorted
      teams.sort_by(&:overall_score).reverse
    end

    def team_by_name(team_name)
      @teams[team_name] ||= Team.new(name: team_name)
    end
  end

  # Generate an array of GameResults models
  class ParseGameResults
    def initialize(input = $stdin)
      @input = input
    end

    def call
      game_results = []
      @input.each_line do |line|
        teams = line.split(',').map!(&:strip)
        away_team = parse_team(teams[0])
        home_team = parse_team(teams[1])
        result = parse_result(away_team, home_team)
        game_results.push(result)
      end
      game_results
    end

    def parse_result(away_team, home_team)
      GameResults.new(
        away_name: away_team[:name],
        away_score: away_team[:score],
        home_name: home_team[:name],
        home_score: home_team[:score]
      )
    end

    def parse_team(team)
      name = team[/(.*) /, 1]
      score = team.split.last
      {
        name: name,
        score: score
      }
    end
  end

  # Calculate league standings from game results
  class CalculateGameResults
    def initialize(game_results, league)
      @game_results = game_results
      @league = league
    end

    def calculate
      @game_results.each do |game_result|
        home_team = @league.team_by_name(game_result.home_name)
        away_team = @league.team_by_name(game_result.away_name)
        away_team.award(3) if game_result.away_won?
        home_team.award(3) if game_result.home_won?
        away_team.award(1) & home_team.award(1) if game_result.tie?
      end
    end
  end
end
