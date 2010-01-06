PATH_PREFIX='http://github.com/diabolo/rails-templates/raw/master/'
#PATH_PREFIX='/Users/andy/dev/rails/rails-templates/'

puts "\n\n**** Git ****"
puts "\n"
load_template "#{PATH_PREFIX}git-init-template.rb"


puts "\n\n**** RSpec ****"
puts "\n"
load_template "#{PATH_PREFIX}rspec-template.rb"

puts "\n\n(::)(::)(::)(::) Cucumber (::)(::)(::)(::)"
puts "\n"
load_template "#{PATH_PREFIX}cucumber-template.rb" if yes?("Use Cucumber?")

# Consider adding machinest, factory-girl etc. as options in fixture replacement
puts "\n\n**** Object Daddy ****"
puts "\n"
load_template "#{PATH_PREFIX}object-daddy-template.rb" if yes?("Use Object Daddy?")

# test environment complete

puts "\n\n**** HAML ****"
puts "\n"
load_template "#{PATH_PREFIX}haml-template.rb" if yes?("Use HAML?")

puts "\n\n**** Compass ****"
puts "\n"
load_template "#{PATH_PREFIX}compass-susy-template.rb" if yes?("Use Compass with Susy?")

puts "\n\n**** Finishing ****"
puts "\n"
load_template "#{PATH_PREFIX}git-init-template.rb"
