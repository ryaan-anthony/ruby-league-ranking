namespace :league_ranking do
  desc 'Calculate league ranking from standings'
  task :calculate do
    game_results = LeagueRankings::ParseGameResults.call
    teams = LeagueRankings::CalculateRankings.new(game_results).calculate
    teams_sorted = sort_results(teams)
    generate_results(teams_sorted)
    # TODO: write tests
  end

  def sort_results(teams)
    teams.sort_by(&:overall_score).reverse
  end

  def generate_results(teams_sorted)
    last = {}
    teams_sorted.each_with_index do |team, index|
      place = last[:score] == team.overall_score ? last[:place] : index + 1
      last[:score] = team.overall_score
      last[:place] = place
      puts "#{place}. #{team.name}, #{points_text(team.overall_score)}"
    end
  end
  
  def points_text(num)
    "#{num} #{num == 1 ? 'pt' : 'pts'}"
  end
end

module LeagueRankings
  class Team
    attr_accessor :name, :overall_score
    def initialize(args)
      @name = args[:name]
      @overall_score = args[:overall_score] || 0
    end
    def award(points)
      @overall_score += points
    end
  end
  class GameResults
    attr_reader :away_team, :home_team,
                :away_score, :home_score
    def initialize(args)
      @away_team = args[:away_team]
      @away_score = args[:away_score]
      @home_team = args[:home_team]
      @home_score = args[:home_score]
    end
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
  class ParseGameResults
    def self.call(input = $stdin)
      results = []
      input.each_line do |line|
        teams = line.split(',').map!(&:strip)
        away_team = parse_team(teams[0])
        home_team = parse_team(teams[1])
        result = parse_result(away_team, home_team)
        results.push(result)
      end
      results
    end
    def self.parse_result(away_team, home_team)
      GameResults.new(
        away_team: away_team[:name],
        away_score: away_team[:score],
        home_team: home_team[:name],
        home_score: home_team[:score]
      )
    end
    def self.parse_team(team)
      name = team[/(.*) /, 1]
      score = team.split.last
      {
        name: name,
        score: score
      }
    end
  end
  class CalculateRankings
    def initialize(game_results)
      @game_results = game_results
      @teams = {}
    end

    def calculate
      @game_results.each do |game_result|
        home_team = team_by_name(game_result.home_team)
        away_team = team_by_name(game_result.away_team)
        if game_result.away_won?
          away_team.award(3)
        elsif game_result.home_won?
          home_team.award(3)
        elsif game_result.tie?
          away_team.award(1)
          home_team.award(1)
        end
      end
      @teams.values
    end

    protected

    def team_by_name(team_name)
      @teams[team_name] ||= Team.new(name: team_name)
    end
  end
end
