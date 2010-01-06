plugin 'object_daddy',  :git => 'git://github.com/flogic/object_daddy.git', :submodule => true
git :submodule => "init"
git :submodule => "update"

git :add => '.'
git :commit => "-a -m 'Setting up object_daddy'"
