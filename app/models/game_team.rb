module LeagueRankings
  # A data model for game teams
  class GameTeam < Team
    attr_accessor :score
    def initialize(args)
      super(args)
      @score = args[:score]
    end
  end
end
