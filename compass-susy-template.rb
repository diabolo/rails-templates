# compass and susy
gem 'compass', :lib => false
gem 'compass-susy-plugin', :lib => 'susy'
rake 'gems:install', :sudo => true
run "compass -r susy -f susy --rails --sass-dir app/stylesheets --css-dir public/stylesheets"
git :add => '.'
git :commit => "-a -m 'Setting up compass with susy'"
