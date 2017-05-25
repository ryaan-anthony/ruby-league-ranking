module LeagueRankings
  # Generate an array of GameResults models
  # @param IO
  class ParseGameResults
    def initialize(input = $stdin)
      @input = input
    end

    def call
      game_results = []
      @input.each do |line|
        result = parse_line(line)
        game_results.push(result)
      end
      game_results
    rescue
      raise ParserError
    end

    def parse_line(line)
      teams = line.split(',').map!(&:strip)
      away_team = parse_team(teams[0])
      home_team = parse_team(teams[1])
      parse_result(away_team, home_team)
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
      score = team.split.last.to_i
      {
        name: name,
        score: score
      }
    end
  end
end
