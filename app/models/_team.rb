module LeagueRankings
  # A data model for teams
  class Team
    attr_accessor :name
    def initialize(args)
      @name = args[:name]
    end
  end
end
