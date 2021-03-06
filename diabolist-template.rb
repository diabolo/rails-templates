# git initialisation
#


# rails:rm_tmp_dirs
["./tmp/pids", "./tmp/sessions", "./tmp/sockets", "./tmp/cache"].each do |f|
  run("rmdir ./#{f}")
end

#delete existing log files
run 'rm log/*.*'

# git:hold_empty_dirs
run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")

# git:rails:new_app
git :init

git :add => "."
git :commit => "-a -m 'Initial rails setup. Ensure empty dirs (log, tmp) are in repo.'"

file '.gitignore', <<-CODE
log/*.*
tmp/*
public/cache/**/*
doc/api
doc/app
config/database.yml
vendor/plugins/doc/**/*
public/stylesheets/*
public/images/products/*
db/*.sqlite3
db/*.sqlite3-journal
db/schema.rb
db/*journal*
coverage/*
.DS_Store
vendor/rails
CODE

git :add => ".gitignore"
git :commit => "-a -m '.gitignore setup.'"


inside('config') do
  run "cp database.yml database.sample.yml"
end

git :add => "."
git :commit => "-a -m 'Setup default database.yml using sqlite'"


####################
# testing
####################

git :rm => "test/"
git :add => "."
git :commit => "-a -m 'Remove test_unit tests in preparation for rspec'"


# configure test environment for rspec and cucumber
# cucumber will configure its own environment later, but before we can do that we need
# the cucumber-rails gem installed
gem "rspec-rails", :lib => false, :env => 'test'
gem "cucumber-rails", :lib => false, :env => 'test'

git :add => "."
git :commit => "-a -m 'configured config/test.rb to require rspec and cucumber so we can bootstrap test enviromnet'"

rake 'gems:install', :sudo => true, :env => 'test'

generate :rspec

git :add => "."
git :commit => "-a -m 'run rspec generator'"

generate('cucumber', '--capybara --rspec')

git :add => '.'
git :commit => "-a -m 'ran cucumber generator with --capybara --rspec'"

# now install gems required by cucumber setup
rake 'gems:install', :sudo => true, :env => 'cucumber'

# plugin 'object_daddy',  :git => 'git://github.com/flogic/object_daddy.git', :submodule => true
# git :submodule => "init"
# git :submodule => "update"

# git :add => '.'
# git :commit => "-a -m 'Setting up test environment, using cucumber, rspec, webrat, object_daddy'"


################
# production
################

# haml
gem 'haml', :lib => 'haml'
rake 'gems:install GEM=haml', :sudo => true
run "haml --rails #{run "pwd"}"
git :add => '.'
git :commit => "-a -m 'Setup haml'"

# compass and susy
gem 'compass', :lib => false
gem 'compass-susy-plugin', :lib => 'susy'
rake 'gems:install', :sudo => true
run "compass -r susy -f susy --rails --sass-dir app/stylesheets --css-dir public/stylesheets"
git :add => '.'
git :commit => "-a -m 'Setting up compass with susy'"

# finish up
rake('db:create:all')
rake('db:migrate')
rake('db:test:clone')

file 'app/lib/tasks/restart.rake',
%q{
desc "Restart Passenger mod_rails under Apache 2.x"
task :restart do
  FileUtils.touch(File.join(RAILS_ROOT, 'tmp', 'restart.txt'), :verbose => true)
end
}

git :add => '.'
git :commit => "-a -m 'Finishing up'"





