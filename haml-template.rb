# haml
gem 'haml', :lib => 'haml'
rake 'gems:install GEM=haml', :sudo => true
run "haml --rails #{run "pwd"}"
git :add => '.'
git :commit => "-a -m 'Setup haml'"
