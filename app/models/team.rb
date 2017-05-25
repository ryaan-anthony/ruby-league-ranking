module LeagueRankings
  # A data model for teams
  class Team
    include Awardable
    attr_accessor :name, :overall_score
    def initialize(args)
      @name = args[:name]
      @overall_score = args[:overall_score] || 0
    end
  end
end
