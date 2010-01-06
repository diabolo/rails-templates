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
