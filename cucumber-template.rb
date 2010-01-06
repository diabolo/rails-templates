# configure application to use cucumber
gem "cucumber-rails", :lib => false, :env => 'test'

git :add => "."
git :commit => "-a -m 'configured config/test.rb to require cucumber-rails so we can bootstrap cucumber enviromnet'"

puts "\nWill attempt to install cucumber-rails as sudo, please provide password\n\t"

rake 'gems:install', :sudo => true, :env => 'test'

# cucumber options
options = []
options << 'rspec'  # keeping this as a default for now

puts "\nChoose webrat or capybara\n\t"

# options << 'webrat' if yes?("Use Webrat with cucumber?")
# options << 'capybara' if yes?("Use Capybara with cucumber?")


if yes?("Use Webrat with cucumber?")
  options << 'webrat' 
else
  options << 'capybara' if yes?("Use Capybara with cucumber?")
end

args = options.collect{|o| "--#{o}"}.join(' ')

generate('cucumber', args)

git :add => "."
git :commit => "-a -m 'ran cucumber generator with arguments #{args}'"



