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
  coverage/
  CODE
          
  inside('config') do
    run "cp database.yml database.sample.yml"
  end
 
  git :add => "."
 
  git :commit => "-a -m 'Setting up a new rails app. Copy config/database.yml.sample to config/database.yml and customize.'"
 
   

# testing
#
  gem "rspec", :lib => "spec", :env => 'test'
  gem "rspec-rails", :lib => "spec/rails", :env => 'test'
  gem "cucumber", :source => "http://gems.github.com", :env => 'test'
  gem "rcov", :env => 'test'

                                              
  rake("gems:install RAILS_ENV=test", :sudo => true)
                                                    
  generate :rspec
  generate :cucumber 
  run "rm -rf /test"
  
  git :add => '.'
  git :commit => "-a -m 'Setting up test environment, using cucumber and rspec'"


# production
# 

  # haml
  # run "haml --rails ."
  
