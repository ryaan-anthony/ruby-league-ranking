require 'test/unit'
Dir.glob('app/errors/*.rb').each { |r| load r }
Dir.glob('app/models/concerns/*.rb').each { |r| load r }
Dir.glob('app/models/*.rb').each { |r| load r }
Dir.glob('app/services/*.rb').each { |r| load r }
class TestCase < Test::Unit::TestCase; end
