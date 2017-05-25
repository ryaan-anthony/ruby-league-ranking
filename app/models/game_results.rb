module LeagueRankings
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
end
