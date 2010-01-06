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
