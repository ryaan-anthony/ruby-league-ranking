require 'rake/testtask'
Dir.glob('app/errors/*.rb').each { |r| load r }
Dir.glob('app/models/concerns/*.rb').each { |r| load r }
Dir.glob('app/models/*.rb').each { |r| load r }
Dir.glob('app/services/*.rb').each { |r| load r }
Dir.glob('lib/tasks/*.rake').each { |r| load r }
Rake::TestTask.new('league_ranking:test') { |t| t.test_files = FileList['test/**/*_test.rb'] }
