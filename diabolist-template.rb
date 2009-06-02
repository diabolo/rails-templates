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
  gem "rspec", :lib => "spec", :env => 'test'
  gem "rspec-rails", :lib => "spec/rails", :env => 'test'
  gem "cucumber", :source => "http://gems.github.com", :env => 'test'
  gem "rcov", :env => 'test'
     
  rake 'gems:install', :sudo => true, :env => 'test'    
  generate :rspec
  generate :cucumber 
  run "rm -rf /test"

  plugin 'object_daddy',  :git => 'git://github.com/flogic/object_daddy.git'
  
  git :add => '.'
  git :commit => "-a -m 'Setting up test environment, using cucumber, rspec, webrat, object_daddy'"


# production
# 

  # haml         
  gem 'haml-edge', :lib => 'haml' 
  rake 'gems:install GEM=haml-edge', :sudo => true   
  run "haml --rails #{run "pwd"}"                                                         
  git :add => '.'
  git :commit => "-a -m 'Setup haml'"

  #compass
  gem 'chriseppstein-compass', :lib => "compass", :source => 'http://gems.github.com/'    
  rake 'gems:install GEM=chriseppstein-compass', :sudo => true      
        
  run "compass --rails --framework blueprint --sass-dir app/stylesheets --css-dir public/stylesheets"
  git :add => '.'
  git :commit => "-a -m 'Setting up compass'"         
  
  
  
  
  
  
  
  
  
