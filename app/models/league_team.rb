module LeagueRankings
  # A data model for league teams
  class LeagueTeam < Team
    include Awardable
    attr_accessor :overall_score
    def initialize(args)
      super(args)
      @overall_score = args[:overall_score] || 0
    end
  end
end
