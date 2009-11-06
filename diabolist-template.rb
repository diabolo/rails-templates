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
 
  file '.gitignore', <<-CODE
.DS_Store
config/database.yml
coverage/
db/*.sqlite3
db/*.sqlite3-journal  
doc/api
doc/app
log/*.log  
log/*.pid   
public/cache/**/*
tmp/**/*
CODE
          
  inside('config') do
    run "cp database.yml database.sample.yml"
  end
 
  git :add => "."
 
  git :commit => "-a -m 'Setting up a new rails app. Copy config/database.yml.sample to config/database.yml and customize.'"
 
   

# testing
#
  #run "touch config/environments/cucumber.rb"
  %w(test).each do |env|
    gem "rspec", :lib => false, :env => env
    gem "rspec-rails", :lib => false, :env => env
    gem "cucumber", :lib => false, :env => env
    gem "rcov", :lib => false, :env => env
    rake 'gems:install', :sudo => true, :env => env
  end
      
  generate :rspec
  generate :cucumber 
  #run "rm -rf /test"

  plugin 'object_daddy',  :git => 'git://github.com/flogic/object_daddy.git', :submodule => true
  git :submodule => "init"
  git :submodule => "update"
  
  git :add => '.'
  git :commit => "-a -m 'Setting up test environment, using cucumber, rspec, webrat, object_daddy'"


# production
# 

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
  
  
    
  
  
  
  
  
  
