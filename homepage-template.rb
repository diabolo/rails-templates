file 'app/helpers/application_helper.rb', 
%q{module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
   
  def include_css_and_js
    #TODO 
  end
   
end
}

file 'app/views/layouts/_flashes.html.haml', 
%q{
#flash
  - flash.each do |key, value|
    %div{id="flash_#{key}}
      =h value 
}

file 'app/views/layouts/application.html.haml', 
%q{
!!! XML
!!!
%html{html_attrs(:lang => 'en-GB')}
  %head
    %title =PROJECT_NAME.humanize 
    = include_css_and_js
  %body{class="#{body_class}"}
    = render :partial => 'layouts/flashes
    = yield      
}

file 'app/controllers/welcome_controller.rb', 
%q{
class WelcomeController < ApplicationController
  def index
  end
end  
}

route "map.root :controller => 'welcome'"  
git :rm => "public/index.html"  

file 'app/views/welcome/index.html.haml', 
%q{
=Welcome to #{PROJECT_NAME.humanize}
}
  
git :add => ".", :commit => "-m 'adding welcome ....'"
    
