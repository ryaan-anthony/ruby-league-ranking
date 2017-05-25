module LeagueRankings
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
      @teams[team_name] ||= LeagueTeam.new(name: team_name)
    end
  end
end
