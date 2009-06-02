# git initialisation
#

  # rails:rm_tmp_dirs
  ["./tmp/pids", "./tmp/sessions", "./tmp/sockets", "./tmp/cache"].each do |f|
    run("rmdir ./#{f}")
  end
 
  # git:hold_empty_dirs
  run("find . \\( -type d -empty \\) -and \\( -not -regex ./\\.git.* \\) -exec touch {}/.gitignore \\;")
 
  # git:rails:new_app
  git :init
 
  initializer '.gitignore', <<-CODE
  log/\\*.log
  log/\\*.pid
  db/\\*.db
  db/\\*.sqlite3
  db/schema.rb
  tmp/\\*\\*/\\*
  .DS_Store
  doc/api
  doc/app
  config/database.yml
  CODE
 
  run "cp config/database.yml config/database.yml.sample"
 
  git :add => "."
 
  git :commit => "-a -m 'Setting up a new rails app. Copy config/database.yml.sample to config/database.yml and customize.'"
 


# testing
#
  gem "rspec", :lib => "spec", :env => 'test'
  gem "rspec-rails", :lib => "spec/rails", :env => 'test'
  gem "cucumber", :source => "http://gems.github.com", :env => 'test'
  gem "rcov", :env => 'test'

                                              
  rake("gems:install", :sudo => true, :env => test)

  git :add => '.'
  git :commit => "-a -m 'Testing stuff installed'"
