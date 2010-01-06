# configure test environment for rspec

gem "rspec-rails", :lib => false, :env => 'test'

git :add => "."
git :commit => "-a -m 'configured config/test.rb to require rspec so we can bootstrap test enviromnet'"

puts "\nWill attempt to install rspec-rails as sudo, please provide password\n\t"

rake 'gems:install', :sudo => true, :env => 'test'

generate :rspec

git :add => "."
git :commit => "-a -m 'run rspec generator'"
